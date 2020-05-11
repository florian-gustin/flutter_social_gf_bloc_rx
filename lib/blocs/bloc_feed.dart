import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/models/post.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/services/firebase.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:rxdart/rxdart.dart';

class BlocFeed extends BlocBase {
  BlocFeed() {
    _firebase = Firebase();
    posts = [];
    users = [];
  }

  List<Post> posts;
  List<User> users;
  Firebase _firebase;

  PublishSubject<List<User>> _controller = PublishSubject<List<User>>();
  Stream<List<User>> get usersStream => _controller.stream;
  Sink<List<User>> get usersSink => _controller.sink;

  Stream<QuerySnapshot> get queryData =>
      _firebase.dbPosts.where('uid', whereIn: [
        'H9pkKuAtlBeor7MMLdV2YKA9tRM2',
        'c2ElHIDQs9PgggQGfa9pRPM98nx1'
      ]).snapshots();

  void handleData(QuerySnapshot querySnapshot) {
    posts = [];
    users = [];
    querySnapshot.documents.forEach((doc) {
      Post post = Post(doc);
      posts.add(post);
      _firebase.dbUsers
          .where(kUID, isEqualTo: post.userID)
          .snapshots()
          .map((QuerySnapshot querySnapshot) => querySnapshot.documents)
          .listen((usrs) {
        User user = User(usrs[0]);
        users.add(user);
        print(users);
        // REQUIRED
        syncUsers();
      });
    });
  }

  void handleLike(Post post) => _firebase.addLike(post);
  void handleComment(DocumentReference ref, String text, String postAuthor) =>
      _firebase.addComment(ref, text, postAuthor);
  void syncUsers() => usersSink.add(users);

  @override
  void dispose() {
    _controller.close();
    fDisposingBlocOf('Bloc Feed');
  }
}
