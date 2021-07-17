import 'package:flutter/material.dart';
import 'package:tovit/app/LoginScreen/View/LoginScreen1.dart';
import 'package:tovit/app/LoginScreen/View/signupscreen.dart';
import 'package:tovit/app/LoginScreen/View/verifypage.dart';
import 'package:tovit/app/SplashSreen/view/splashscreen.dart';
import 'package:tovit/app/homeScreen.dart/homescreen.dart';
import 'package:tovit/app/searchpage/searchpage.dart';

import 'routeNames.dart' as routes;

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.LOGINVIEWROUTE:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case routes.SIGNUPVIEWROUTE:
      return MaterialPageRoute(builder: (context) => SignUpScreen());
    case routes.STARTUPVIEWROUTE:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case routes.HOMESCREENROUTE:
      return MaterialPageRoute(builder: (context) => HomeScreen());
    case routes.SEARCHPAGE:
      return MaterialPageRoute(builder: (context) => SearchPage());
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
