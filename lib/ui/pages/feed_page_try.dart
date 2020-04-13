import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_feed_try.dart';
import 'package:flutter_social_gf_bloc_rx/models/post.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets/my_sliver_app_bar.dart';
import 'package:flutter_social_gf_bloc_rx/ui/tiles/post_tile.dart';

class FeedPageTry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final feed = BlocProvider.of<BlocFeedTry>(context);

    return NestedScrollView(
      headerSliverBuilder: (BuildContext build, bool scrolled) {
        return [MySliverAppBar(title: "Fil d'actualité", image: homeImage)];
      },
      body: StreamBuilder(
        stream: feed.queryData,
        builder: (ctx, snap) {
          if (snap.hasData) {
            print(snap.data);
            final QuerySnapshot querySnapshot = snap.data;
            feed.handleData(querySnapshot);
            return ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: feed.posts.length,
              itemBuilder: (BuildContext context, int index) {
                Post post = feed.posts[index];
                return PostTile(
                  post: post,
                  user: myAccount,
                  detail: false,
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
