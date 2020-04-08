import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firebase {
  final FirebaseAuth authInstance = FirebaseAuth.instance;
  static final Firestore dbInstance = Firestore.instance;

  Stream<FirebaseUser> get onAuthStateChanged =>
      authInstance.onAuthStateChanged;

  // auth
  Future<FirebaseUser> signIn(String mail, String pwd) async {
    final AuthResult user = await authInstance.signInWithEmailAndPassword(
        email: mail, password: pwd);
    return user.user;
  }

  Future<FirebaseUser> signUp(
      String mail, String pwd, String firstname, String lastname) async {
    final AuthResult user = await authInstance.createUserWithEmailAndPassword(
        email: mail, password: pwd);
    // create user
    String uid = user.user.uid;
    Map<String, dynamic> map = {
      'firstname': firstname,
      'lastname': lastname,
      'imageUrl': '',
      'followers': <dynamic>[],
      'following': <dynamic>[uid],
      'uid': uid,
    };
    addUser(uid, map);
    return user.user;
  }

  void signOut() => authInstance.signOut();

  // db
  final dbUsers = dbInstance.collection('users');

  void addUser(String uid, Map<String, dynamic> map) {
    dbUsers.document(uid).setData(map);
  }

  // storage

}
