import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/models/comment.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;
  final Stream stream;

  const CommentTile({
    Key key,
    @required this.comment,
    @required this.stream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: stream,
      builder: (BuildContext ctx, snap) {
        if (snap.hasData) {
          User user = User(snap.data);
          return Container(
            color: white,
            margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 2.5),
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        MyImageProfile(
                          url: user.imageUrl,
                          onPressed: null,
                          size: 15.0,
                        ),
                        MyText(
                          '${user.firstname} ${user.lastname}',
                          color: base,
                        ),
                      ],
                    ),
                    MyText(
                      comment.date,
                      color: pointer,
                    )
                  ],
                ),
                MyText(
                  comment.text,
                  color: baseAccent,
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
