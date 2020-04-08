import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class MyBottomBar extends StatelessWidget {
  final List<Widget> items;

  const MyBottomBar({
    Key key,
    @required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: baseAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: items,
      ),
    );
  }
}
