import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/constants.dart';
import 'package:flutter_social_gf_bloc_rx/models/user_firebase.dart';
import 'package:flutter_social_gf_bloc_rx/services/firebase.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets/my_alert.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets/my_constants.dart';
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

  authConnect(bool exist, BuildContext context) {
    hideKeyboard(context);

    if (mail.text == null || mail.text == '')
      return MyAlert().error(context, 'None email address');
    if (pwd.text == null || pwd.text == '')
      return MyAlert().error(context, 'None password');
    if (exist) {
      _firebase.onAuthStateChanged.listen((FirebaseUser user) {
//        return _firebase.signIn(mail.text, pwd.text);
      });
    } else {
      if (firstname.text == null || firstname.text == '')
        return MyAlert().error(context, 'None first name');
      if (lastname.text == null || lastname.text == '')
        return MyAlert().error(context, 'None last name');

      _firebase.onAuthStateChanged.listen((FirebaseUser user) {
//        return _firebase.signUp(
//            mail.text, pwd.text, firstname.text, lastname.text);
      });
    }
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
