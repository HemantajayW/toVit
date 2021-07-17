import 'package:flutter/material.dart';
import 'package:tovit/enums/deviceType.dart';

import 'ResponsiveWidget.dart';

class ScreenTypeLayout extends StatelessWidget {
  // Mobile will be returned by default
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ScreenTypeLayout(
      {Key? key, required this.mobile, this.tablet, this.desktop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (context, sizingInformation) {
      // If sizing indicates Tablet and we have a tablet widget then return
      if (sizingInformation.deviceType == DeviceType.TABLET) {
        if (tablet != null) {
          return tablet;
        }
      }

      // If sizing indicates desktop and we have a desktop widget then return
      if (sizingInformation.deviceType == DeviceType.DESKTOP) {
        if (desktop != null) {
          return desktop;
        }
      }

      // Return mobile layout if nothing else is supplied
      return mobile;
    });
  }
}
