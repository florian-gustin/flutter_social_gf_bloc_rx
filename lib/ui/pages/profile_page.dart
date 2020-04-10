import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_feed.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_home.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_profile.dart';
import 'package:flutter_social_gf_bloc_rx/models/post.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:flutter_social_gf_bloc_rx/ui/tiles/post_tile.dart';
import 'package:image_picker/image_picker.dart';

import '../theme/widgets.dart';
import '../theme/widgets.dart';

class ProfilePage extends StatelessWidget {
  void updateImageProfile(BuildContext context, BlocProfile profile) {
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
//                  MyTextField(
//                    controller: profile.firstname,
//                    hint: profile.user.firstname,
//                  ),
//                  MyTextField(
//                    controller: profile.lastname,
//                    hint: profile.user.lastname,
//                  ),
//                  MyTextField(
//                    controller: profile.description,
//                    hint: profile.user.description,
//                  ),
//                  MyGradientButton(onPressed: () {}, text: 'Update')
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = GetBloc.of<BlocProfile>(context);
    final home = GetBloc.of<BlocHome>(context);

    profile.isMeAsUser(home.streamUser);

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
                              actions: <Widget>[
                                (profile.isMe)
                                    ? IconButton(
                                        icon: iSettings,
                                        onPressed: () =>
                                            profile.handleSignOut(context),
                                        color: pointer,
                                      )
                                    : MyText('Add fun later')
                              ],
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
