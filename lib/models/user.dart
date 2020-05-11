import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class User {
  String uid, firstname, lastname, imageUrl;
  List<dynamic> followers;
  List<dynamic> following;
  DocumentReference ref;
  String documentID;
  String description;

  User(DocumentSnapshot snapshot) {
    ref = snapshot.reference;
    documentID = snapshot.documentID;
    Map<String, dynamic> map = snapshot.data;
    uid = map[kUID];
    firstname = map[kFirstname];
    lastname = map[kLastname];
    imageUrl = map[kImageUrl];
    followers = map[kFollowers];
    following = map[kFollowing];
    description = map[kDescription];
  }

  Map<String, dynamic> toMap() {
    return {
      kUID: uid,
      kFirstname: firstname,
      kLastname: lastname,
      kImageUrl: imageUrl,
      kFollowers: followers,
      kFollowing: following,
      kDescription: description,
    };
  }
}
