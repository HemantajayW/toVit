import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SharedAxisWidget extends StatefulWidget {
  Widget? page1;
  Widget? page2;
  bool? onFirstPage;
  SharedAxisTransitionType? axis;
  SharedAxisWidget(
      {Key? key, this.page1, this.onFirstPage, this.axis, this.page2})
      : super(key: key);

  @override
  _SharedAxisWidgetState createState() => _SharedAxisWidgetState();
}

class _SharedAxisWidgetState extends State<SharedAxisWidget> {
  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      child: widget.onFirstPage! ? widget.page1 : widget.page2,
      duration: const Duration(milliseconds: 300),
      reverse: widget.onFirstPage!,
      transitionBuilder: (Widget child, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SharedAxisTransition(
          child: child,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: widget.axis!,
        );
      },
    );
  }
}
