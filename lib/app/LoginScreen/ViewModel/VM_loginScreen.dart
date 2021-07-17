import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tovit/App%20Services/NavigationService/NavigationService.dart';
import 'package:tovit/App%20Services/authenticationService/AuthenticationService.dart';
import 'package:tovit/App%20Services/locator.dart';
import 'package:tovit/app/LoginScreen/View/verifypage.dart';
import 'package:tovit/app/homeScreen.dart/homescreen.dart';
import 'package:tovit/responsiveUi/baseViewModel.dart';

class VMLoginScreen extends BaseViewModel {
  var formkey = GlobalKey<FormState>();
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  var navservice = locator<NavigationService>();
  var _userEmail;
  var authservice = locator<AuthenticationService>();

  String? validateMail() {
    var temp = mail.text.toLowerCase().split("@");
    if (EmailValidator.validate(mail.text)) {
      if (temp[1] != "vitap.ac.in") {
        return "domain should be @vitap.ac.in";
      }
    } else {
      return "Invalid Email";
    }
  }

  String? validatepassword() {
    if (password.text.length < 6) {
      return "Length should atleast be 6";
    }
  }

  Future<void> signInWithEmailAndLink(context) async {
    var result = await authservice.loginwithmail(mail.text, password.text);
    if (result is bool) {
      if (result == true) {
        await Future.delayed(Duration(seconds: 2));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (c) => HomeScreen()), (route) => false);
      }
      if (result == false) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VerifyPage(email: mail.text)));
      }
    } else if (result is String) {
      showOkAlertDialog(
          context: context, message: result, title: "Error Logging in");
    }
  }
}
