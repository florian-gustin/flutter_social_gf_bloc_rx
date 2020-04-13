import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_feed.dart';
import 'package:flutter_social_gf_bloc_rx/models/post.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets/my_sliver_app_bar.dart';
import 'package:flutter_social_gf_bloc_rx/ui/tiles/post_tile.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final feed = BlocProvider.of<BlocFeed>(context);

    return NestedScrollView(
      headerSliverBuilder: (BuildContext build, bool scrolled) {
        return [MySliverAppBar(title: "Fil d'actualité", image: homeImage)];
      },
      body: StreamBuilder<QuerySnapshot>(
        stream: feed.queryData,
        builder: (ctx, snap) {
          if (snap.hasData) {
            print(snap.data);
            final QuerySnapshot querySnapshot = snap.data;
            feed.handleData(querySnapshot);
            return StreamBuilder<List<User>>(
              stream: feed.usersStream,
              builder: (_, snapshots) {
                if (snapshots.hasData) {
                  final users = snapshots.data;
                  return ListView.builder(
                    padding: EdgeInsets.all(0.0),
                    itemCount: feed.posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      Post post = feed.posts[index];
                      User user = users[index];
                      print('coucou');
                      return PostTile(
                        post: post,
                        user: user,
                        detail: false,
                        onPressedLike: () => feed.handleLike(post),
                        onCommentSubmitted: () => feed.handleComment,
                      );
                    },
                  );
                } else {
                  return MyLoadingCenter();
                }
              },
            );
          } else {
            return MyLoadingCenter();
          }
        },
      ),
    );
  }
}
