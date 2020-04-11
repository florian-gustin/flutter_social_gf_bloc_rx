import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_feed.dart';
import 'package:flutter_social_gf_bloc_rx/models/post.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:flutter_social_gf_bloc_rx/ui/tiles/post_tile.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final feed = GetBloc.of<BlocFeed>(context);

    return NestedScrollView(
      headerSliverBuilder: (_, bool scrolled) {
        return [MySliverAppBar(title: 'News', image: homeImage)];
      },
      body: StreamBuilder<List<Post>>(
        stream: feed.streamPosts,
        builder: (ctx, snap) {
          if (snap.hasData) {
            print(snap.data);
            return ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: snap.data.length,
              itemBuilder: (build, index) {
                print(snap.data);
                Post post = snap.data[index];
//                User user = feed.users.singleWhere((u) => u.uid == post.userID);
                return PostTile(post: post, user: myAccount);
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
