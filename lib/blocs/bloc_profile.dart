import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/services/firebase.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

class BlocProfile extends BlocBase {
  User user;
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

  BehaviorSubject<File> _subjectNewImageTaken = BehaviorSubject<File>();
  Stream<File> get streamNewImageTaken => _subjectNewImageTaken.stream;
  Sink<File> get sinkNewImageTaken => _subjectNewImageTaken.sink;

  BlocProfile({@required this.user}) {
    scrollController = ScrollController();
    syncScrollController();
    _firebase = Firebase();
    expanded = 200.0;
    firstname = TextEditingController();
    lastname = TextEditingController();
    description = TextEditingController();
    _firebase.currentUser.listen((FirebaseUser usr) {
      isMe = (usr.uid == user.uid);
    });
  }
  // need these two functions and a stream to bypass
  // the actual usage of ScrollController Widget
  // for listening in BLoC Pattern
  void scrollControllerListener() {
    scrollController
      ..addListener(() {
        syncScrollController();
      });
  }

  void syncScrollController() => sinkScrollController.add(scrollController);
  Stream<QuerySnapshot> get allPostsFrom => _firebase.allPostsFrom(user.uid);

  void get signOut => _firebase.signOut();

  dynamic handleSignOut(BuildContext context) {
    MyAlert().logOut(context, () {
      signOut;
      popContext(context);
    });
  }

  void takePictureAsStream(ImageSource source) {
    if (isMe) {
      ImagePicker.pickImage(source: source).asStream().listen((File file) {
        newImageTaken = file;
        _firebase.updatePicture(file, user.uid);
        syncNewImageTaken();
      });
    }
  }

  void syncNewImageTaken() => sinkNewImageTaken.add(newImageTaken);

  @override
  void dispose() {
    _subjectNewImageTaken.close();
    firstname.dispose();
    lastname.dispose();
    description.dispose();
    scrollController.dispose();
    _subjectScrollController.close();
    fDisposingBlocOf('Bloc Profile');
  }
}
