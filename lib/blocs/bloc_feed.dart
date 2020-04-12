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
  User user;
  Firebase _firebase;
  List<List<dynamic>> feeds;

  BlocFeed({@required this.user}) {
    _firebase = Firebase();
    feeds = [];
    getData();
  }

  ReplaySubject<List<List<dynamic>>> _subjectData =
      ReplaySubject<List<List<dynamic>>>();
  Stream<List<List<dynamic>>> get streamData => _subjectData.stream;
  Sink<List<List<dynamic>>> get sinkData => _subjectData.sink;

  Stream usersStream() {
    _firebase.dbUsers
        .where(kFollowers, arrayContains: myAccount.uid)
        .snapshots();
  }

  void getData() {
    feeds = [];
    sinkData.add(null);
    _firebase.dbUsers
        .where(kFollowers,
            arrayContains: myAccount.uid) // filter all user that I follow
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.documents)
        .listen((docs) {
      docs.forEach((doc) {
        doc.reference
            .collection('posts')
            .snapshots()
            .map((qSnap) => qSnap.documents)
            .listen((documents) {
          documents.forEach((document) {
            Post post = Post(document);
            if (post.userID != myAccount.uid) {
              _firebase.dbUsers
                  .where(kUID, isEqualTo: post.userID)
                  .snapshots()
                  .map((QuerySnapshot usersQuerySnapshot) =>
                      usersQuerySnapshot.documents)
                  .listen((usersDocs) {
                usersDocs.forEach((usersDoc) {
                  User user = User(usersDoc);
                  feeds.add([post, user]);
                });
              });
            }
          });
        });
      });
    });
    // TODO : need to fix the order
    feeds.sort((a, b) => a[0].date.compareTo(b[0].date));
    sinkData.add(feeds);
  }

  void handleLike(Post post) => _firebase.addLike(post);
  void handleComment(DocumentReference ref, String text, String postAuthor) =>
      _firebase.addComment(ref, text, postAuthor);

  @override
  void dispose() {
    _subjectData.close();
    fDisposingBlocOf('Bloc Feed');
  }
}
