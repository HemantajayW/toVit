import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_utils/keyboard_listener.dart';
import 'package:keyboard_utils/keyboard_utils.dart';
import 'package:tovit/App%20Services/NavigationService/routeNames.dart';
import 'package:tovit/App%20Services/authenticationService/AuthenticationService.dart';
import 'package:tovit/App%20Services/locator.dart';
import 'package:tovit/app/LoginScreen/ViewModel/VM_loginScreen.dart';
import 'package:tovit/app/homeScreen.dart/homescreen.dart';
import 'package:tovit/responsiveUi/ConnectivityView.dart';
import 'package:tovit/responsiveUi/ResponsiveWidget.dart';
import 'package:tovit/responsiveUi/baseView.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<ScaffoldMessengerState> scaffkey =
      GlobalKey<ScaffoldMessengerState>();
  KeyboardUtils _keyboardUtils = KeyboardUtils();
  late int _idKeyboardListener;
  bool? showkeyboard = false;

  var authservice = locator<AuthenticationService>();
  @override
  void initState() {
    _idKeyboardListener = _keyboardUtils.add(
        listener: KeyboardListener(willHideKeyboard: () {
      setState(() {
        showkeyboard = false;
      });
    }, willShowKeyboard: (double keyboardHeight) {
      setState(() {
        showkeyboard = true;
      });
      // Your code here
    }));
    super.initState();
  }

  @override
  void dispose() {
    _keyboardUtils.unsubscribeListener(subscribingId: _idKeyboardListener);
    if (_keyboardUtils.canCallDispose()) {
      _keyboardUtils.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<VMLoginScreen>(
      builder: (context, value, child) => ConnectivityStatusView(
        scaffoldKey: scaffkey,
        builder: (enable) => ResponsiveWidget(
          builder: (context, sizingInfo) => Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Color(0xefefef),
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.only(bottom: 10.0, left: 30, right: 30),
              child: Container(
                child: Form(
                  key: value!.formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "toVit",
                          style: GoogleFonts.monoton(
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
                      ),
                      Spacer(
                        flex: 5,
                      ),
                      !showkeyboard!
                          ? Text(
                              "Hey,\nLets get you in first.",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87),
                            )
                          : SizedBox(),
                      Spacer(
                        flex: 1,
                      ),
                      showkeyboard!
                          ? SizedBox()
                          : Text("Sign in with your University Email",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      fontSize: 14, fontWeight: FontWeight.w500)
                              // .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                      Spacer(
                        flex: 3,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          controller: value.mail,
                          validator: (s) => value.validateMail(),
                          keyboardType: TextInputType.emailAddress,
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                            fillColor: Color(0xffe8e8e8),
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
                            hintText: "University Mail",
                            // focusedBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 2)),
                            enabledBorder: InputBorder.none,
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          controller: value.password,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          style: Theme.of(context).textTheme.bodyText1,
                          validator: (s) => value.validatepassword(),
                          decoration: InputDecoration(
                            fillColor: Color(0xffe8e8e8),
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
                            hintText: "Password",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 2)),
                            enabledBorder: InputBorder.none,
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2),
                            ),
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text("Forgotten Password?",
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 14, color: Colors.grey)),
                      ),
                      Spacer(
                        flex: 4,
                      ),
                      Center(
                        child: IgnorePointer(
                          ignoring: !enable,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: ArgonButton(
                                onTap: (startLoading, stopLoading,
                                    btnState) async {
                                  if (btnState == ButtonState.Idle) {
                                    startLoading();
                                  }
                                  if (value.formkey.currentState!.validate()) {
                                    await value.signInWithEmailAndLink(context);
                                  }

                                  stopLoading();
                                },
                                borderRadius: (10),
                                loader: SpinKitDoubleBounce(
                                  color: Colors.white,
                                  size: 42,
                                ),
                                color: Theme.of(context).accentColor,
                                height: 56,
                                width: sizingInfo.screenSize!.width,
                                child: Text(
                                  "Login",
                                  style: Theme.of(context)
                                      .textTheme
                                      .button!
                                      .copyWith(
                                          fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      InkWell(
                        onTap: () =>
                            value.navservice.navigateTo(SIGNUPVIEWROUTE),
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 32,
                            child: Center(
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: "If you are new / ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              fontSize: 14,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Sign Up ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ])),
                            ),
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}








           //