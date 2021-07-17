import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:tovit/App%20Services/authenticationService/AuthenticationService.dart';
import 'package:tovit/App%20Services/locator.dart';
import 'package:tovit/app/homeScreen.dart/homescreen.dart';
import 'package:tovit/responsiveUi/ResponsiveWidget.dart';

class VerifyPage extends StatefulWidget {
  String email;
  VerifyPage({required this.email, Key? key}) : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  var authservice = locator<AuthenticationService>();
  @override
  void initState() {
    authservice.sendVerificationEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, sizingInfo) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xefefef),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Verify Your Mail",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: 24,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600)),
              Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "check your mail  ",
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 16,
                            ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "${widget.email.toLowerCase()} ",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: "and click on the link to continue.",
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: 16,
                                    ),
                          )
                        ])),
              ),
              Spacer(
                flex: 5,
              ),
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/mailsent.png"))),
              ),
              Spacer(
                flex: 5,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ArgonButton(
                      loader: SpinKitDoubleBounce(
                        color: Colors.white,
                        size: 42,
                      ),
                      onTap: (startLoading, stopLoading, btnState) async {
                        startLoading();
                        print(authservice.isuserverified());
                        if (authservice.isuserverified()) {
                          await Future.delayed(Duration(seconds: 2));
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (c) => HomeScreen()),
                              (route) => false);
                        } else {
                          showOkAlertDialog(
                              context: context,
                              title: "Please Verify Your mail",
                              message:
                                  "Click on the link we have sent you to your mail to verify");
                        }
                        stopLoading();
                      },
                      borderRadius: (10),
                      color: Theme.of(context).accentColor,
                      height: 56,
                      width: sizingInfo.screenSize!.width,
                      child: Text(
                        "Continue",
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
              Text(
                "Resend Email",
                style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
