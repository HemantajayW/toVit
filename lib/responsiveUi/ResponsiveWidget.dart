import 'package:flutter/material.dart';
import 'package:tovit/responsiveUi/sizingInformation.dart';
import 'package:tovit/responsiveUi/ui_utils.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget? Function(
    BuildContext context,
    SizingInformation sizingInfo,
  )? builder;
  ResponsiveWidget({Key? key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxConstraints) {
      var mediaQuery = MediaQuery.of(context);
      var sizingInfo = SizingInformation(
          deviceType: getDeviceType(mediaQuery),
          orientation: mediaQuery.orientation,
          screenSize: mediaQuery.size,
          localWidgetSize:
              Size(boxConstraints.maxWidth, boxConstraints.maxHeight));
      return builder!(context, sizingInfo)!;
    });
  }
}
