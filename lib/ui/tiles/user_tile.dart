import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_home.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_root.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_router.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class UserTile extends StatelessWidget {
  final User user;
  final User me;

  final Function onPressedFollow;

  const UserTile(
      {Key key,
      @required this.user,
      @required this.me,
      @required this.onPressedFollow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          // rewrap with BlocHome to access
          return Scaffold(
            backgroundColor: base,
            body: SafeArea(child: BlocRouter().profile(user: user)),
          );
        }));
      },
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.all(2.5),
        child: Card(
          color: white,
          elevation: 5.0,
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    MyImageProfile(url: user.imageUrl, onPressed: null),
                    MyText(
                      '${user.firstname}',
                      color: base,
                    ),
                  ],
                ),
                (me.uid == user.uid)
                    ? Container(
                        width: 0.0,
                      )
                    : MyFollowButton(
                        user: user,
                        me: me,
                        onPressed: onPressedFollow,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
