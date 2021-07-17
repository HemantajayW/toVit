import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tovit/App%20Services/locator.dart';
import 'package:tovit/app/SplashSreen/viewmodel/VM_SplashScreen.dart';
import 'package:tovit/responsiveUi/baseView.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<StartupLogicModel>(
      onModelReady: (val) => val.handleStartUpLogic(),
      builder: (context, value, child) => Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Color(0xffefefef),
        //   elevation: 0,
        // ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "toVit",
                style: GoogleFonts.monoton(
                    fontSize: 42,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SpinKitThreeBounce(
              size: 24,
              color: Theme.of(context).accentColor,
            )
          ],
        ),
      ),
    );
  }
}
