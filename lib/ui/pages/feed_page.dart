import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_feed.dart';
import 'package:flutter_social_gf_bloc_rx/models/post.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:flutter_social_gf_bloc_rx/ui/tiles/post_tile.dart';

class FeedPage extends StatelessWidget {
  test(List<Post> snapshot) {
    List<Widget> l = [];
    snapshot.forEach((element) {
      l.add(PostTile(post: element, user: myAccount));
    });
    return l;
  }

  @override
  Widget build(BuildContext context) {
    final feed = GetBloc.of<BlocFeed>(context);

    return NestedScrollView(
      headerSliverBuilder: (_, bool scrolled) {
        return [MySliverAppBar(title: 'News', image: homeImage)];
      },
      body: RefreshIndicator(
        onRefresh: () async {
          feed.getData();
        },
        child: StreamBuilder<List<List<dynamic>>>(
          stream: feed.streamData,
          builder: (ctx, snap) {
            if (snap.hasData) {
              return ListView.builder(
                padding: EdgeInsets.all(0.0),
                itemCount: snap.data.length,
                itemBuilder: (build, index) {
                  Post post = snap.data[index][0];
                  User user = snap.data[index][1];
                  return PostTile(
                    post: post,
                    user: user,
                    onPressedLike: () {
                      feed.handleLike(post);
                    },
                    onCommentSubmitted: feed.handleComment,
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
