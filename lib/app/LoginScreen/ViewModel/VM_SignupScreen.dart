import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tovit/App%20Services/NavigationService/NavigationService.dart';
import 'package:tovit/App%20Services/authenticationService/AuthenticationService.dart';
import 'package:tovit/App%20Services/locator.dart';
import 'package:tovit/App%20Services/snackbarService.dart/snackbarsevice.dart';
import 'package:tovit/app/LoginScreen/View/verifypage.dart';
import 'package:tovit/responsiveUi/baseViewModel.dart';

class VM_SignUpScreen extends BaseViewModel {
  var formkey = GlobalKey<FormState>();
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repassword = TextEditingController();
  var cases = [false, false, false, false];

  var navservice = locator<NavigationService>();
  var _userEmail;
  var authservice = locator<AuthenticationService>();
  void validatePassword(str) {
    RegExp exp1 = RegExp(r"[A-Z]");
    RegExp exp2 = RegExp(r"[a-z]");
    RegExp exp3 = RegExp(r"(\d)");
    RegExp exp4 = RegExp(r"(\W)");
    var temp = password.text;
    cases[0] = exp3.hasMatch(temp);
    cases[1] = exp2.hasMatch(temp);
    cases[2] = exp1.hasMatch(temp);
    cases[3] = exp4.hasMatch(temp);
    print("$password $cases");
    notifyListeners();
  }

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
    } else if (cases.contains(false)) {
      return "Please choose a strong password";
    }
  }

  String? validaterepassword() {
    if (password.text.length < 6) {
      return "Length should atleast be 6";
    } else if (password.text != repassword.text) {
      return "Password didn't match";
    }
  }

  registermail(context) async {
    var result = await authservice.registermail(mail.text, password.text);

    if (result is bool) {
      if (result == true) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VerifyPage(email: mail.text)));
      }
    } else if (result is String) {
      showOkAlertDialog(
          context: context, message: result, title: "Error Signing up");
    }
  }
}
