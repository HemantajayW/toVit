import 'package:flutter/material.dart';
import 'package:material_snackbar/snackbar.dart';
import 'package:material_snackbar/snackbar_messenger.dart';
import 'package:tovit/App%20Services/Themes/textTheme.dart';

import '../../main.dart';

void callInfoSnackbaar(
  GlobalKey<ScaffoldMessengerState> key, {
  Widget? icon,
  required String message,
  Duration? duration,
}) {
  if (duration == null) {
    duration = Duration(seconds: 2);
  }
  rootScaffoldMessengerKey.currentState?.clearSnackBars();
  rootScaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
    content: Row(
      children: [
        icon ?? SizedBox(),
        SizedBox(
          width: 5,
        ),
        Container(
          child: Text(
            message,
            // style: RobotoStyle.copyWith(fontSize: 14),
          ),
        ),
      ],
    ),
    duration: duration,

    behavior: SnackBarBehavior.floating,
    // margin: EdgeInsets.symmetric(vertical: 10),
  ));
}
