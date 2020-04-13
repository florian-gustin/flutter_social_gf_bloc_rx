import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_feed.dart';
import 'package:flutter_social_gf_bloc_rx/models/post.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/services/firebase.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:flutter_social_gf_bloc_rx/ui/tiles/post_tile.dart';

class FeedPage extends StatefulWidget {
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<FeedPage> {
  StreamSubscription sub;
  List<Post> posts = [];
  List<User> users = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupSub();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NestedScrollView(
        headerSliverBuilder: (BuildContext build, bool scrolled) {
          return [MySliverAppBar(title: "Fil d'actualité", image: homeImage)];
        },
        body: ListView.builder(
            padding: EdgeInsets.all(0.0),
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              Post post = posts[index];
              User user = users.singleWhere((u) => u.uid == post.userID);
              return PostTile(
                post: post,
                user: user,
                detail: false,
              );
            }));
  }

  setupSub() {
    sub = Firebase()
        .dbUsers
        .where(kFollowers, arrayContains: myAccount.uid)
        .snapshots()
        .listen((datas) {
      getUsers(datas.documents);
      datas.documents.forEach((docs) {
        docs.reference.collection("posts").snapshots().listen((post) {
          if (!mounted) return;
          setState(() {
            posts = getPosts(post.documents);
          });
        });
      });
    });
  }

  getUsers(List<DocumentSnapshot> userDocs) {
    List<User> myList = users;
    userDocs.forEach((u) {
      User user = User(u);
      if (myList.every((p) => p.uid != user.uid)) {
        myList.add(user);
      } else {
        User toBeChanged = myList.singleWhere((p) => p.uid == user.uid);
        myList.remove(toBeChanged);
        myList.add(user);
      }
    });
    if (!mounted) return;
    setState(() {
      users = myList;
    });
  }

  List<Post> getPosts(List<DocumentSnapshot> postDocs) {
    List<Post> myList = posts;
    postDocs.forEach((p) {
      Post post = Post(p);
      if (myList.every((p) => p.documentID != post.documentID)) {
        myList.add(post);
      } else {
        Post toBeChanged =
            myList.singleWhere((p) => p.documentID == post.documentID);
        myList.remove(toBeChanged);
        myList.add(post);
      }
    });
    myList.sort((a, b) => b.date.compareTo(a.date));
    return myList;
  }
}

//class FeedPage extends StatelessWidget {

//
//  @override
//  Widget build(BuildContext context) {
//    final feed = GetBloc.of<BlocFeed>(context);
//
//    return NestedScrollView(
//      headerSliverBuilder: (_, bool scrolled) {
//        return [MySliverAppBar(title: 'News', image: homeImage)];
//      },
//      body: RefreshIndicator(
//        onRefresh: () async {
//          feed.getData();
//        },
//        child: StreamBuilder<List<List<dynamic>>>(
//          stream: feed.streamData,
//          builder: (ctx, snap) {
//            if (snap.hasData) {
//              return ListView.builder(
//                padding: EdgeInsets.all(0.0),
//                itemCount: snap.data.length,
//                itemBuilder: (build, index) {
//                  Post post = snap.data[index][0];
//                  User user = snap.data[index][1];
//                  return PostTile(
//                    post: post,
//                    user: user,
//                    onPressedLike: () {
//                      feed.handleLike(post);
//                    },
//                    onCommentSubmitted: feed.handleComment,
//                  );
//                },
//              );
//            }
//            return Container();
//          },
//        ),
//      ),
//    );
//  }
//}
