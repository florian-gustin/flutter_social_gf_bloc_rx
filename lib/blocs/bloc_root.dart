import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/services/firebase.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets/my_alert.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets/my_constants.dart';

class BlocRoot extends BlocBase {
  Firebase _firebase;
  PageController pageController;
  TextEditingController mail;
  TextEditingController pwd;
  TextEditingController firstname;
  TextEditingController lastname;
  Stream<FirebaseUser> get onAuthStateChanged => _firebase.onAuthStateChanged;

  BlocRoot() {
    _firebase = Firebase();
    pageController = PageController();
    mail = TextEditingController();
    pwd = TextEditingController();
    firstname = TextEditingController();
    lastname = TextEditingController();
  }

  dynamic authConnect(bool exist, BuildContext context) {
    hideKeyboard(context);

    if (mail.text == null || mail.text == '')
      return MyAlert().error(context, 'None email address');
    if (pwd.text == null || pwd.text == '')
      return MyAlert().error(context, 'None password');
    if (exist) {
      // log in
      _firebase.signInAsStream(mail.text, pwd.text);
    } else {
      if (firstname.text == null || firstname.text == '')
        return MyAlert().error(context, 'None first name');
      if (lastname.text == null || lastname.text == '')
        return MyAlert().error(context, 'None last name');

      // register
      _firebase.signUpAsStream(
          mail.text, pwd.text, firstname.text, lastname.text);
    }
  }

  void signOut() => _firebase.signOut();

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
