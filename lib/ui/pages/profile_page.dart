import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_feed.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_home.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_profile.dart';
import 'package:flutter_social_gf_bloc_rx/models/post.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:flutter_social_gf_bloc_rx/ui/tiles/post_tile.dart';
import 'package:image_picker/image_picker.dart';

import '../theme/widgets.dart';

class ProfilePage extends StatelessWidget {
  void updateImageProfile(BuildContext context, BlocProfile profile) {
    if (!profile.isMe) return;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          color: Colors.transparent,
          child: Card(
            elevation: 5.0,
            margin: EdgeInsets.all(7.5),
            child: Container(
              padding: EdgeInsets.all(10.0),
              color: base,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MyText(
                    'Your Image Profile',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: iCam,
                        onPressed: () {
                          profile.takePictureAsStream(ImageSource.camera);
                          popContext(context);
                        },
                      ),
                      IconButton(
                        icon: iGallery,
                        onPressed: () {
                          profile.takePictureAsStream(ImageSource.gallery);
                          popContext(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void updateFields(BuildContext context, BlocProfile profile) {
    MyAlert().updateUserAlert(context,
        firstname: profile.firstname,
        lastname: profile.lastname,
        description: profile.description,
        user: profile.user, onValidation: () {
      profile.handleUpdateUserInfos();
      popContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final profile = GetBloc.of<BlocProfile>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: profile.allPostsFrom,
      builder: (ctx, snap) {
        final documents = snap?.data?.documents;
        return (snap.hasData)
            ? StreamBuilder<User>(
                stream: profile.streamUser,
                builder: (ctx, s) {
                  final user = s?.data;
                  print(profile.isMe);
                  return (s.hasData)
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
                                        actions: <Widget>[
                                          (profile.isMe)
                                              ? IconButton(
                                                  icon: iSettings,
                                                  onPressed: () => profile
                                                      .handleSignOut(context),
                                                  color: pointer,
                                                )
                                              : MyFollowButton(
                                                  user: user,
                                                  me: profile.me,
                                                  onPressed: () =>
                                                      profile.handleFollow())
                                        ],
                                        flexibleSpace: FlexibleSpaceBar(
                                          title: MyText(profile.showTitle
                                              ? (user.lastname +
                                                  ' ' +
                                                  user.firstname)
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
                                                url: user.imageUrl,
                                                size: 75.0,
                                                onPressed: () {
                                                  this.updateImageProfile(
                                                      context, profile);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SliverPersistentHeader(
                                        pinned: true,
                                        delegate: MyHeaderDelegate(
                                            isMe: profile.isMe,
                                            user: user,
                                            callback: () => this
                                                .updateFields(context, profile),
                                            scrolled: profile.showTitle),
                                      ),
                                      SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                          (BuildContext context, index) {
                                            if (index == documents.length)
                                              return ListTile(
                                                title: MyText('End of list'),
                                              );

                                            if (index > documents.length)
                                              return null;

                                            final post = Post(documents[index]);
                                            return PostTile(
                                                post: post,
                                                user: user,
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
              )
            : MyLoadingCenter();
      },
    );
  }
}
