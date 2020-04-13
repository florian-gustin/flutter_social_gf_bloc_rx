import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_social_gf_bloc_rx/models/post.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import '';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class Firebase {
  final FirebaseAuth authInstance = FirebaseAuth.instance;
  static final Firestore dbInstance = Firestore.instance;
  static final StorageReference storageInstance =
      FirebaseStorage.instance.ref();

  Firebase();

  Stream<FirebaseUser> get onAuthStateChanged =>
      authInstance.onAuthStateChanged;

  Stream<FirebaseUser> get currentUser => authInstance.currentUser().asStream();

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
      kFirstname: firstname,
      kLastname: lastname,
      kImageUrl: '',
      kFollowers: <dynamic>[uid],
      kFollowing: <dynamic>[],
      kUID: uid,
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
  final dbNotifs = dbInstance.collection('notifications');
  final dbPosts = dbInstance.collectionGroup('posts');

  void addUser(String uid, Map<String, dynamic> map) {
    dbUsers.document(uid).setData(map);
  }

  void updateUser(String uid, Map<String, dynamic> map) {
    dbUsers.document(uid).updateData(map);
  }

  void upsertFollow(User other, User me) {
    if (me.following.contains(other.uid)) {
      me.ref.updateData({
        kFollowing: FieldValue.arrayRemove([other.uid])
      });
      other.ref.updateData({
        kFollowers: FieldValue.arrayRemove([me.uid])
      });
    } else {
      me.ref.updateData({
        kFollowing: FieldValue.arrayUnion([other.uid])
      });
      other.ref.updateData({
        kFollowers: FieldValue.arrayUnion([me.uid])
      });
      addNotif(myAccount.uid, other.uid,
          '${myAccount.firstname} is following you', myAccount.ref, kFollowers);
    }
  }

  void addNotif(
      String from, String to, String text, DocumentReference ref, String type) {
    Map<String, dynamic> map = {
      kUID: from,
      kText: text,
      kType: type,
      kRef: ref,
      kWatched: false,
      kDate: DateTime.now().millisecondsSinceEpoch.toInt(),
    };
    dbNotifs.document(to).collection('singleNotif').add(map);
  }

  void addPost(String uid, String text, File file) {
    int date = DateTime.now().millisecondsSinceEpoch.toInt();
    Map<String, dynamic> map = {
      kUID: uid,
      kLikes: <dynamic>[],
      kComments: <dynamic>[],
      kDate: date,
    };
    if (text != null && text != '') map[kText] = text;
    if (file != null) {
      StorageReference ref = storagePost.child(uid).child(date.toString());
      addImage(file, ref).then((onEnd) {
        String imageUrl = onEnd;
        map[kImageUrl] = imageUrl;
        dbUsers.document(uid).collection('posts').document().setData(map);
      });
    } else {
      dbUsers.document(uid).collection('posts').document().setData(map);
    }
  }

  void addLike(Post post) {
    if (post.likes.contains(myAccount.uid)) {
      post.ref.updateData({
        kLikes: FieldValue.arrayRemove([myAccount.uid])
      });
    } else {
      post.ref.updateData({
        kLikes: FieldValue.arrayUnion([myAccount.uid])
      });
      addNotif(myAccount.uid, post.userID,
          '${myAccount.firstname} liked your post', post.ref, kLikes);
    }
  }

  void addComment(DocumentReference ref, String text, String postAuthor) {
    Map<dynamic, dynamic> map = {
      kUID: myAccount.uid,
      kText: text,
      kDate: DateTime.now().millisecondsSinceEpoch.toInt()
    };
    ref.updateData({
      kComments: FieldValue.arrayUnion([map])
    });
    addNotif(myAccount.uid, postAuthor,
        '${myAccount.firstname} has commented your post', ref, kComments);
  }

  Stream<QuerySnapshot> allPostsFrom(String uid) =>
      dbUsers.document(uid).collection('posts').snapshots();

  // storage
  final storageUser = storageInstance.child('users');
  final storagePost = storageInstance.child('posts');

  Future<String> addImage(File file, StorageReference ref) async {
    StorageUploadTask task = ref.putFile(file);
    StorageTaskSnapshot snapshot = await task.onComplete;
    String url = await snapshot.ref.getDownloadURL();
    return url;
  }

  Stream<String> addImageAsStream(File file, StorageReference ref) {
    return Stream.fromFuture(addImage(file, ref));
  }

  void updatePicture(File file, String uid) {
    StorageReference ref = storageUser.child(uid);
    addImage(file, ref).asStream().listen((path) {
      Map<String, dynamic> m = {kImageUrl: path};
      updateUser(uid, m);
    });
  }
}
