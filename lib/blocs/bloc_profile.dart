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

  BlocProfile({@required this.user}) {
    scrollController = ScrollController();
    syncScrollController();
    _firebase = Firebase();
    expanded = 200.0;
    firstname = TextEditingController();
    lastname = TextEditingController();
    description = TextEditingController();
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
      });
    }
  }

  void isMeAsUser(Stream<User> userStream) {
    userStream.listen((usr) {
      if (usr.uid == user.uid) {
        isMe = true;
        user = usr;
      } else {
        isMe = false;
      }
    });
  }

  @override
  void dispose() {
    firstname.dispose();
    lastname.dispose();
    description.dispose();
    scrollController.dispose();
    _subjectScrollController.close();
    fDisposingBlocOf('Bloc Profile');
  }
}
