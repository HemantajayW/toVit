import 'package:flutter/material.dart';
import 'package:tovit/enums/deviceType.dart';

DeviceType getDeviceType(MediaQueryData mediaQuery) {
  var orientation = mediaQuery.orientation;

  double deviceWidth = 0;

  if (orientation == Orientation.landscape) {
    deviceWidth = mediaQuery.size.height;
  } else {
    deviceWidth = mediaQuery.size.width;
  }

  if (deviceWidth > 950) {
    return DeviceType.DESKTOP;
  }

  if (deviceWidth > 600) {
    return DeviceType.TABLET;
  }

  return DeviceType.MOBILE;
}
