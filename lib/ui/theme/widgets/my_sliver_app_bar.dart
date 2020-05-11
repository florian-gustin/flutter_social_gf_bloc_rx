import 'package:flutter/material.dart';
import '../widgets.dart';

class MySliverAppBar extends StatelessWidget {
  final String title;
  final AssetImage image;
  final double height;

  const MySliverAppBar({
    Key key,
    @required this.title,
    @required this.image,
    this.height = 150.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: MyText(
          title,
          color: white,
        ),
        background: Image(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
      expandedHeight: height,
    );
  }
}
