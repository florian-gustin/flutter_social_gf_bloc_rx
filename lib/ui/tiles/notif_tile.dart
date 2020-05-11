import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_router.dart';
import 'package:flutter_social_gf_bloc_rx/models/notif.dart';
import 'package:flutter_social_gf_bloc_rx/models/post.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class NotifTile extends StatelessWidget {
  final Notif notif;
  final Function stream;

  const NotifTile({
    Key key,
    @required this.notif,
    @required this.stream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: stream(notif.userID),
      builder: (ctx, snap) {
        if (snap.hasData) {
          User user = User(snap.data);
          return InkWell(
            onTap: () {
//              notif.notifRef.updateData({kWatched: true});
              if (notif.type == kFollowers) {
                Navigator.push(context, MaterialPageRoute(builder: (build) {
                  return Scaffold(
                    backgroundColor: white,
                    body: BlocRouter().profile(user: user),
                  );
                }));
              } else {
                notif.ref.get().then((snap) {
                  Post post = Post(snap);
                  BlocRouter().comments(
                      context: ctx, user: user, post: post, onSubmit: null);
                });
              }
            },
            child: Container(
              color: Colors.transparent,
              margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
              child: Card(
                elevation: 5.0,
                color: (!notif.watched) ? white : base,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          MyImageProfile(url: user.imageUrl, onPressed: () {}),
                          MyText(
                            notif.date,
                            color: pointer,
                          )
                        ],
                      ),
                      MyText(
                        notif.text,
                        color: baseAccent,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
