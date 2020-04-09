import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class MyImageProfile extends StatelessWidget {
  final double size;
  final String url;
  final Function onPressed;

  const MyImageProfile({
    Key key,
    this.size = 20.0,
    @required this.url,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: CircleAvatar(
        radius: size,
        backgroundImage: (url != null && url != '')
            ? CachedNetworkImageProvider(url)
            : logoImage,
        backgroundColor: white,
      ),
    );
  }
}
