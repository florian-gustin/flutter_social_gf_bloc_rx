import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firebase {
  final FirebaseAuth authInstance = FirebaseAuth.instance;
  static final Firestore dbInstance = Firestore.instance;

  Firebase();

  Stream<FirebaseUser> get onAuthStateChanged =>
      authInstance.onAuthStateChanged;

  // auth
  Future<FirebaseUser> signIn(String mail, String pwd) async {
    final AuthResult user = await authInstance.signInWithEmailAndPassword(
        email: mail, password: pwd);
    return user?.user;
  }

  Stream<FirebaseUser> signInAsStream(String mail, String pwd) {
    return authInstance
        .signInWithEmailAndPassword(email: mail, password: pwd)
        .catchError(print)
        .asStream()
        .map((AuthResult authResult) => authResult?.user);
  }

  Future<FirebaseUser> signUp(
      String mail, String pwd, String firstname, String lastname) async {
    final AuthResult user = await authInstance.createUserWithEmailAndPassword(
        email: mail, password: pwd);
    // create user
    String uid = user?.user?.uid;
    Map<String, dynamic> map = {
      'firstname': firstname,
      'lastname': lastname,
      'imageUrl': '',
      'followers': <dynamic>[],
      'following': <dynamic>[uid],
      'uid': uid,
    };
    addUser(uid, map);
    return user?.user;
  }

  Stream<FirebaseUser> signUpAsStream(
      String mail, String pwd, String firstname, String lastname) {
    authInstance
        .createUserWithEmailAndPassword(email: mail, password: pwd)
        .catchError(print)
        .asStream()
        .listen((AuthResult authResult) {
      String uid = authResult?.user?.uid;
      if (uid != null) {
        Map<String, dynamic> map = {
          'firstname': firstname,
          'lastname': lastname,
          'imageUrl': '',
          'followers': <dynamic>[],
          'following': <dynamic>[uid],
          'uid': uid,
        };
        addUser(uid, map);
      }
      return authResult?.user;
    });
  }

  void signOut() => authInstance.signOut();

  // db
  final dbUsers = dbInstance.collection('users');

  void addUser(String uid, Map<String, dynamic> map) {
    dbUsers.document(uid).setData(map);
  }

  // storage

}
