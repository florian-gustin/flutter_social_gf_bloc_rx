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
  List<Post> allPosts = [];
  List<User> allUsers;

  List<Post> desiredPosts = [];
  List<User> users = [];

  BlocFeed({@required this.user}) {
    _firebase = Firebase();
    myTest();
  }

  BehaviorSubject<List<Post>> _subjectPosts = BehaviorSubject<List<Post>>();
  Stream<List<Post>> get streamPosts => _subjectPosts.stream;
  Sink<List<Post>> get sinkPosts => _subjectPosts.sink;

  ReplaySubject<List<User>> _subjectUsers = ReplaySubject<List<User>>();
  Stream<List<User>> get streamUsers => _subjectUsers.stream;
  Sink<List<User>> get sinkUsers => _subjectUsers.sink;

  myTest() {
    allPosts = [];
    _firebase.dbUsers
        .where(kFollowers, arrayContains: myAccount.uid)
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.documents)
        .listen((docs) {
      docs.forEach((doc) {
        doc.reference
            .collection('posts')
            .snapshots()
            .map((qSnapshot) => qSnapshot.documents)
            .listen((documents) {
          documents.forEach((document) {
            Post post = Post(document);
            if (post.userID != myAccount.uid) allPosts.add(post);
          });
        });
      });
    });
//    print(allPosts);
    sinkPosts.add(allPosts);
  }

  setupSub() {
    _firebase.dbUsers
        .where(kFollowers, arrayContains: myAccount.uid)
        .snapshots()
        .listen((datas) {
      print('datas :  ${datas.documents}');
      getUsers(datas.documents);
      datas.documents.forEach((doc) {
        doc.reference.collection('posts').snapshots().listen((postsSnap) {
          print('postsnap : $postsSnap');
          desiredPosts = getPosts(postsSnap.documents);
        });
      });
    });
  }

  List<Post> getPosts(List<DocumentSnapshot> postsDocs) {
    List<Post> l = desiredPosts;
    print('tst : $l');
    postsDocs.forEach((p) {
      Post post = Post(p);
      if (l.every((p) => p.documentID != post.documentID)) {
        l.add(post);
      } else {
        Post toBeChanged =
            l.singleWhere((p) => p.documentID == post.documentID);
        l.remove(toBeChanged);
        l.add(post);
      }
    });
    return l;
  }

  void getUsers(List<DocumentSnapshot> userDocs) {
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
    users = myList;
  }

  initSub() {
    allPosts = [];
    _firebase.dbUsers
        .where(kFollowers, arrayContains: myAccount.uid)
        .snapshots()
        .listen((datas) {
      datas.documents.forEach((doc) {
        doc.reference.collection('posts').snapshots().listen((posts) {
          var postsDoc = posts.documents;
          postsDoc.forEach((p) {
            Post post = Post(p);
            if (post.userID != myAccount.uid) {
              allPosts.add(post);
            }
          });
        });
      });
      sinkPosts.add(allPosts);
    });
  }

  @override
  void dispose() async {
    await _subjectPosts.drain();
    _subjectPosts.close();
    _subjectUsers.close();
    fDisposingBlocOf('Bloc Feed');
  }
}
