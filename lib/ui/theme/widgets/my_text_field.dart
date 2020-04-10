import 'package:flutter/material.dart';

//class MyTextField extends TextField {
//  MyTextField(
//      {@required TextEditingController controller,
//      TextInputType type = TextInputType.text,
//      String hint = '',
//      Icon icon,
//      bool obscure: false})
//      : super(
//          controller: controller,
//          keyboardType: type,
//          obscureText: obscure,
//          decoration: InputDecoration(hintText: hint, icon: icon),
//        );
//}

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String hint;
  final Icon icon;
  final bool obscure;

  const MyTextField({
    Key key,
    @required this.controller,
    this.type = TextInputType.text,
    this.hint = '',
    this.icon,
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextField(
        controller: controller,
        keyboardType: type,
        obscureText: obscure,
        decoration: InputDecoration(hintText: hint, icon: icon),
      ),
    );
  }
}
