import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tovit/App%20Services/NavigationService/routeNames.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> login() {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(HOMESCREENROUTE, (route) => false);
  }

  Future<dynamic> pushandRemove(route) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(route, (route) => false);
  }

  Future<dynamic> googleLogin() {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(PROFILESHOW, (route) => false);
  }

  // Future<dynamic> logout() {
  //   return navigatorKey.currentState!
  //       .pushNamedAndRemoveUntil(FIRSTSCREEN, (route) => false);
  // }

  goBack() {
    return navigatorKey.currentState!.pop();
  }
}
