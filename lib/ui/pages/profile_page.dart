import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_feed.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_profile.dart';
import 'package:flutter_social_gf_bloc_rx/models/post.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:flutter_social_gf_bloc_rx/ui/tiles/post_tile.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile = GetBloc.of<BlocProfile>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: profile.allPostsFrom,
      builder: (ctx, snap) {
        final documents = snap?.data?.documents;
        return (snap.hasData)
            ? StreamBuilder(
                stream: profile.streamScrollController,
                builder: (context, snapshot) {
                  profile.scrollControllerListener();
                  final controller = snapshot?.data;
                  return (snapshot.hasData)
                      ? CustomScrollView(
                          controller: controller,
                          slivers: <Widget>[
                            SliverAppBar(
                              pinned: true,
                              expandedHeight: profile.expanded,
                              actions: <Widget>[],
                              flexibleSpace: FlexibleSpaceBar(
                                title: MyText(profile.showTitle
                                    ? (profile.user.lastname +
                                        ' ' +
                                        profile.user.firstname)
                                    : ''),
                                background: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: profileImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Center(
                                    child: MyImageProfile(
                                        url: profile.user.imageUrl,
                                        size: 75.0,
                                        onPressed: () {}),
                                  ),
                                ),
                              ),
                            ),
                            SliverPersistentHeader(
                              pinned: true,
                              delegate: MyHeaderDelegate(
                                  user: profile.user,
                                  callback: () {},
                                  scrolled: profile.showTitle),
                            ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, index) {
                                  if (index == documents.length)
                                    return ListTile(
                                      title: MyText('End of list'),
                                    );

                                  if (index > documents.length) return null;

                                  final post = Post(documents[index]);
                                  return PostTile(
                                      post: post,
                                      user: profile.user,
                                      detail: null);
                                },
                              ),
                            ),
                          ],
                        )
                      : SizedBox();
                })
            : MyLoadingCenter();
      },
    );
  }
}
