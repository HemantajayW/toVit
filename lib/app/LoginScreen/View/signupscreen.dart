import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tovit/app/LoginScreen/ViewModel/VM_SignupScreen.dart';
import 'package:tovit/responsiveUi/ResponsiveWidget.dart';
import 'package:tovit/responsiveUi/baseView.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FocusNode mailf = FocusNode();
  FocusNode passf = FocusNode();
  FocusNode cpassf = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BaseView<VM_SignUpScreen>(
      builder: (context, value, child) => ResponsiveWidget(
        builder: (context, sizingInfo) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              "Sign Up",
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            ),
            backgroundColor: Color(0xefefef),
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.only(
                bottom: 10.0, left: 30, right: 30, top: 30),
            child: Form(
              key: value!.formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  itsmytextfield(context, value,
                      fcnode: mailf,
                      heading: "Email",
                      onChanged: (str) {},
                      controller: value.mail,
                      tptype: TextInputType.emailAddress,
                      validator: value.validateMail(),
                      helpertext:
                          "You'll have to verify that you own this email account.",
                      hint: "University Mail"),
                  Spacer(
                    flex: 1,
                  ),
                  itsmytextfield(context, value,
                      fcnode: passf,
                      onChanged: value.validatePassword,
                      controller: value.password,
                      obscure: true,
                      validator: value.validatepassword(),
                      tptype: TextInputType.visiblePassword,
                      heading: "Password",
                      helpertext:
                          "Please create a Secure Password including the criteria bellow.",
                      hint: "Password"),
                  passf.hasFocus
                      ? Wrap(
                          spacing: 5,
                          children: [
                            ChoiceChip(
                                padding: EdgeInsets.only(left: 5),
                                labelPadding: EdgeInsets.only(
                                    right: 12, left: value.cases[0] ? 0 : 12),
                                selectedColor: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.5),
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(color: Color(0XFF25514a)),
                                disabledColor: Color(0xffe7e7e7),
                                label: Text(
                                  "number",
                                ),
                                avatar: value.cases[0]
                                    ? Icon(
                                        Icons.check,
                                        color: Color(0XFF25514a),
                                      )
                                    : null,
                                selected: value.cases[0]),
                            ChoiceChip(
                                padding: EdgeInsets.only(left: 5),
                                labelPadding: EdgeInsets.only(
                                    right: 12, left: value.cases[1] ? 0 : 12),
                                selectedColor: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.5),
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(color: Color(0XFF25514a)),
                                disabledColor: Color(0xffe7e7e7),
                                label: Text(
                                  "lowercase letter",
                                ),
                                avatar: value.cases[1]
                                    ? Icon(
                                        Icons.check,
                                        color: Color(0XFF25514a),
                                      )
                                    : null,
                                selected: value.cases[1]),
                            ChoiceChip(
                                padding: EdgeInsets.only(left: 5),
                                labelPadding: EdgeInsets.only(
                                    right: 12, left: value.cases[2] ? 0 : 12),
                                selectedColor: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.5),
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(color: Color(0XFF25514a)),
                                disabledColor: Color(0xffe7e7e7),
                                label: Text(
                                  "uppercase letter",
                                ),
                                avatar: value.cases[2]
                                    ? Icon(
                                        Icons.check,
                                        color: Color(0XFF25514a),
                                      )
                                    : null,
                                selected: value.cases[2]),
                            ChoiceChip(
                                padding: EdgeInsets.only(left: 5),
                                labelPadding: EdgeInsets.only(
                                    right: 12, left: value.cases[2] ? 0 : 12),
                                selectedColor: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.5),
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(color: Color(0XFF25514a)),
                                disabledColor: Color(0xffe7e7e7),
                                label: Text(
                                  "Spl Char",
                                ),
                                avatar: value.cases[3]
                                    ? Icon(
                                        Icons.check,
                                        color: Color(0XFF25514a),
                                      )
                                    : null,
                                selected: value.cases[3]),
                          ],
                        )
                      : SizedBox(),
                  Spacer(
                    flex: 1,
                  ),
                  itsmytextfield(context, value,
                      fcnode: cpassf,
                      controller: value.repassword,
                      obscure: true,
                      onChanged: (str) {},
                      validator: value.validaterepassword(),
                      tptype: TextInputType.visiblePassword,
                      heading: "Confirm Password",
                      helpertext:
                          "Retype the password you have typed above top confirm.",
                      hint: "Retype password"),
                  Spacer(
                    flex: 1,
                  ),
                  Spacer(
                    flex: 6,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ArgonButton(
                          onTap: (startLoading, stopLoading, btnState) async {
                            if (btnState == ButtonState.Idle) {
                              startLoading();
                            }
                            if (value.formkey.currentState!.validate()) {
                              await value.registermail(context);
                            }
                            stopLoading();
                          },
                          loader: SpinKitDoubleBounce(
                            color: Colors.white,
                            size: 42,
                          ),
                          borderRadius: (10),
                          color: Theme.of(context).accentColor,
                          height: 56,
                          width: sizingInfo.screenSize!.width,
                          child: Text(
                            "Sign Up",
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "If you Already have acc / ",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Login ",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                              ),
                            ])),
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
    );
  }
  // "You'll have to verify that you own this email account."

  Column itsmytextfield(BuildContext context, VM_SignUpScreen? value,
      {required String heading,
      required String hint,
      bool obscure = false,
      required TextEditingController controller,
      required TextInputType tptype,
      required validator,
      required onChanged,
      required String helpertext,
      required FocusNode fcnode}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(heading,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600)),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: TextFormField(
            obscureText: obscure,
            onChanged: onChanged,
            controller: controller,
            validator: (s) => validator,
            autofocus: !obscure,
            focusNode: fcnode,
            keyboardType: tptype,
            onTap: () {
              setState(() {});
            },
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
              fillColor: fcnode.hasFocus ? Colors.white54 : Color(0xffe6e6e6),
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.red, width: 2)),
              hintText: hint,
              helperMaxLines: 3,

              helperText: fcnode.hasFocus ? helpertext : null,
              helperStyle: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
              // focusedBorder: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).accentColor, width: 2)),
              enabledBorder: InputBorder.none,
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.red, width: 2)),
            ),
          ),
        ),
      ],
    );
  }
}
// ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: TextFormField(
//                     controller: value.password,
//                     obscureText: true,
//                     keyboardType: TextInputType.visiblePassword,
//                     style: Theme.of(context).textTheme.bodyText1,
//                     decoration: InputDecoration(
//                       fillColor: Color(0xffe8e8e8),
//                       filled: true,
//                       contentPadding:
//                           EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       hintText: "Password",
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(
//                               color: Theme.of(context).accentColor, width: 2)),
//                       enabledBorder: InputBorder.none,
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Spacer(
//                   flex: 1,
//                 ),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: TextFormField(
//                     controller: value.password,
//                     obscureText: true,
//                     keyboardType: TextInputType.visiblePassword,
//                     style: Theme.of(context).textTheme.bodyText1,
//                     decoration: InputDecoration(
//                       fillColor: Color(0xffe8e8e8),
//                       filled: true,
//                       contentPadding:
//                           EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       hintText: "Confirm Password",
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(
//                               color: Theme.of(context).accentColor, width: 2)),
//                       enabledBorder: InputBorder.none,
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                   ),
//                 ),