import 'package:cached_network_image/cached_network_image.dart';
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
    this.detail,
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
              (post.imageUrl != null && post.imageUrl != '')
                  ? MyPadding(
                      child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1.0,
                      color: baseAccent,
                    ))
                  : Container(
                      height: 0.0,
                    ),
              (post.imageUrl != null && post.imageUrl != '')
                  ? MyPadding(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                                image:
                                    CachedNetworkImageProvider(post.imageUrl),
                                fit: BoxFit.cover)),
                      ),
                    )
                  : Container(
                      height: 0.0,
                    ),
              (post.text != null && post.text != '')
                  ? MyPadding(
                      child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1.0,
                      color: baseAccent,
                    ))
                  : Container(
                      height: 0.0,
                    ),
              (post.text != null && post.text != '')
                  ? MyPadding(
                      child: MyText(
                      post.text,
                      color: baseAccent,
                    ))
                  : Container(
                      height: 0.0,
                    ),
              MyPadding(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.0,
                  color: baseAccent,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                      icon: (post.likes.contains(user.uid))
                          ? iLikeFull
                          : iLikeEmpty,
                      onPressed: null),
                  MyText(
                    post.likes.length.toString(),
                    color: baseAccent,
                  ),
                  IconButton(icon: iMsg, onPressed: null),
                  MyText(
                    post.comments.length.toString(),
                    color: baseAccent,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
