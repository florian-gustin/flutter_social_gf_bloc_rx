import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/models/post.dart';
import 'package:flutter_social_gf_bloc_rx/services/firebase.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:rxdart/rxdart.dart';

class BlocFeedTry extends BlocBase {
  BlocFeedTry() {
    _firebase = Firebase();
    posts = [];
  }

  List<Post> posts;
  Firebase _firebase;

  PublishSubject subject = PublishSubject();

  Stream<QuerySnapshot> get queryData =>
      _firebase.dbPosts.where('uid', whereIn: [
        'H9pkKuAtlBeor7MMLdV2YKA9tRM2',
        'c2ElHIDQs9PgggQGfa9pRPM98nx1'
      ]).snapshots();

  void handleData(QuerySnapshot querySnapshot) {
    posts = [];
    querySnapshot.documents.forEach((doc) {
      Post post = Post(doc);
      posts.add(post);
    });
  }

  @override
  void dispose() {}
}
