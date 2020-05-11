import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class MyFollowButton extends StatelessWidget {
  final User user;
  final User me;
  final Function onPressed;

  const MyFollowButton({
    Key key,
    @required this.user,
    @required this.me,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: MyText(
        (me.following.contains(user.uid)) ? 'Unfollow' : 'Follow',
        color: pointer,
      ),
    );
  }
}
