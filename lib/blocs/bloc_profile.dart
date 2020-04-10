import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_home.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/services/firebase.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

class BlocProfile extends BlocBase {
  User user;
  User me;
  Firebase _firebase;
  bool isMe;
  ScrollController scrollController;
  double expanded;
  TextEditingController firstname;
  TextEditingController lastname;
  TextEditingController description;
  File newImageTaken;

  bool get showTitle {
    return scrollController.hasClients &&
        scrollController.offset > expanded - kToolbarHeight;
  }

  BehaviorSubject<ScrollController> _subjectScrollController =
      BehaviorSubject<ScrollController>();
  Stream<ScrollController> get streamScrollController =>
      _subjectScrollController.stream;
  Sink<ScrollController> get sinkScrollController =>
      _subjectScrollController.sink;

  BehaviorSubject<User> _subjectUser = BehaviorSubject<User>();
  Stream<User> get streamUser => _subjectUser.stream;
  Sink<User> get sinkUser => _subjectUser.sink;

  BlocProfile({@required this.user}) {
    scrollController = ScrollController();
    syncScrollController();
    _firebase = Firebase();
    expanded = 200.0;
    firstname = TextEditingController();
    lastname = TextEditingController();
    description = TextEditingController();
    // retrieve datas from streams
    refreshingUsers();
  }

  void refreshingUsers() {
    _firebase.currentUser.map((FirebaseUser user) => user.uid).listen((uid) {
      _firebase.dbUsers.document(user.uid).snapshots().listen((data) {
        user = User(data);
        if (uid == user.uid) {
          isMe = true;
        } else {
          isMe = false;
        }
        _firebase.dbUsers.document(uid).snapshots().listen((datas) {
          me = User(datas);
        });
        sinkUser.add(user);
      });
    });
  }

  // need these two functions and a stream to bypass
  // the actual usage of ScrollController Widget
  // to listening from BLoC Pattern
  void scrollControllerListener() {
    scrollController
      ..addListener(() {
        syncScrollController();
      });
  }

  void syncScrollController() => sinkScrollController.add(scrollController);

  Stream<QuerySnapshot> get allPostsFrom => _firebase.allPostsFrom(user.uid);

  void get signOut => _firebase.signOut();

  void handleFollow() => _firebase.upsertFollow(user, me);

  dynamic handleSignOut(BuildContext context) {
    MyAlert().logOut(context, () {
      signOut;
      popContext(context);
    });
  }

  handleUpdateUserInfos() {
    Map<String, dynamic> data = {};
    if (firstname.text != null && firstname.text != '')
      data[kFirstname] = firstname.text;
    if (lastname.text != null && lastname.text != '')
      data[kLastname] = lastname.text;
    if (description.text != null && description.text != '')
      data[kDescription] = description.text;
    _firebase.updateUser(user.uid, data);
  }

  void takePictureAsStream(ImageSource source) {
    if (isMe) {
      ImagePicker.pickImage(source: source, maxHeight: 500.0, maxWidth: 500.0)
          .asStream()
          .listen((File file) {
        newImageTaken = file;
        _firebase.updatePicture(file, user.uid);
      });
    }
  }

  @override
  void dispose() async {
    firstname.dispose();
    lastname.dispose();
    description.dispose();
    scrollController.dispose();
    _subjectScrollController.close();
    fDisposingBlocOf('Bloc Profile');
    await _subjectUser.drain();
    _subjectUser.close();
  }
}
