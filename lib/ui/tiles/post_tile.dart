import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/models/post.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class PostTile extends StatelessWidget {
  final Post post;
  final User user;
  final bool detail;

  const PostTile({
    Key key,
    @required this.post,
    @required this.user,
    @required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: Card(
        elevation: 5.0,
        child: MyPadding(
          top: 10.0,
          right: 10.0,
          bottom: 10.0,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MyImageProfile(
                    url: user.imageUrl,
                    onPressed: () {},
                  ),
                  Column(
                    children: <Widget>[
                      MyText(
                        '${user.firstname}  ${user.lastname}',
                        color: baseAccent,
                      ),
                      MyText(
                        '${post.date}',
                        color: pointer,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
