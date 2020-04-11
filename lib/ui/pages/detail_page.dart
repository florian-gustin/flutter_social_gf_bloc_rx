import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_detail.dart';
import 'package:flutter_social_gf_bloc_rx/models/comment.dart';
import 'package:flutter_social_gf_bloc_rx/models/post.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets/my_loading_center.dart';
import 'package:flutter_social_gf_bloc_rx/ui/tiles/comment_tile.dart';
import 'package:flutter_social_gf_bloc_rx/ui/tiles/post_tile.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final detail = GetBloc.of<BlocDetail>(context);

    return StreamBuilder<DocumentSnapshot>(
      stream: detail.post.ref.snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          Post post = Post(snapshot.data);
          return ListView.builder(
            itemCount: post.comments.length + 1,
            itemBuilder: (BuildContext ctx, index) {
              if (index == 0) {
                return PostTile(
                  post: post,
                  user: detail.user,
                  detail: true,
                );
              } else {
                Comment comment = Comment(post.comments[index - 1]);
                return CommentTile(
                    comment: comment,
                    stream: detail.commentTileStream(comment.userID));
              }
            },
          );
        } else {
          return MyLoadingCenter();
        }
      },
    );
  }
}
