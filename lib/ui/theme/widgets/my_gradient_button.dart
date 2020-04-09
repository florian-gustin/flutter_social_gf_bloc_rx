import 'package:flutter/material.dart';

import '../widgets.dart';
import 'my_gradient.dart';

class MyGradientButton extends StatelessWidget {
  final double elevation;
  final double width;
  final double height;
  final Function onPressed;
  final String text;

  const MyGradientButton({
    Key key,
    this.elevation = 7.5,
    @required this.onPressed,
    this.width = 300.0,
    this.height = 50.0,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(height / 2),
      ),
      elevation: elevation,
      child: Container(
        width: 300.0,
        height: 50.0,
        decoration: MyGradient(
          startColor: baseAccent,
          endColor: base,
          radius: height / 2,
          isHorizontal: true,
        ),
        child: FlatButton(
          onPressed: onPressed,
          child: MyText(text),
        ),
      ),
    );
  }
}
