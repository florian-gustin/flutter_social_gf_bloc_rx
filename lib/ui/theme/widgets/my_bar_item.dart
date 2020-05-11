import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class MyBarItem extends StatelessWidget {
  final Icon icon;
  final Function onPressed;
  final bool selected;

  const MyBarItem({
    Key key,
    @required this.icon,
    @required this.onPressed,
    @required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: onPressed,
      color: selected ? pointer : base,
    );
  }
}
