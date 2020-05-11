import 'package:flutter/material.dart';

class MyPadding extends Padding {
  MyPadding({
    @required Widget child,
    double top = 10,
    double left = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) : super(
            padding: EdgeInsets.only(
                top: top, left: left, right: right, bottom: bottom),
            child: child);
}
