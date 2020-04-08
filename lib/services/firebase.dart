import 'package:firebase_auth/firebase_auth.dart';

class Firebase {
  final FirebaseAuth authInstance = FirebaseAuth.instance;

  Stream<FirebaseUser> get onAuthStateChanged =>
      authInstance.onAuthStateChanged;
}
