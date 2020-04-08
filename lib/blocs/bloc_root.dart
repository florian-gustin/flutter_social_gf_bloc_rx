import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/constants.dart';
import 'package:flutter_social_gf_bloc_rx/models/user_firebase.dart';
import 'package:flutter_social_gf_bloc_rx/services/firebase.dart';
import 'package:rxdart/rxdart.dart';

class BlocRoot extends BlocBase {
  Firebase _firebase;
  PageController pageController;
  TextEditingController mail;
  TextEditingController pwd;
  TextEditingController firstname;
  TextEditingController lastname;

  BehaviorSubject<UserFirebase> _subjectUserFirebase =
      BehaviorSubject<UserFirebase>();
  Stream<UserFirebase> get stream => _subjectUserFirebase.stream;
  Sink<UserFirebase> get sink => _subjectUserFirebase.sink;

  Stream<FirebaseUser> get onAuthStateChanged => _firebase.onAuthStateChanged;

  BlocRoot() {
    _firebase = Firebase();
    pageController = PageController();
    mail = TextEditingController();
    pwd = TextEditingController();
    firstname = TextEditingController();
    lastname = TextEditingController();
  }

  @override
  void dispose() {
    pageController.dispose();
    mail.dispose();
    pwd.dispose();
    firstname.dispose();
    lastname.dispose();
    fDisposingBlocOf('Bloc Root');
  }
}
