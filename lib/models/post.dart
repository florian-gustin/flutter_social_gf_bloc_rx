import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class Post {
  DocumentReference ref;
  String documentID, id, text, userID, imageUrl;
  int date;
  List<dynamic> likes;
  List<dynamic> comments;

  User user;

  Post(this.user, DocumentSnapshot snapshot) {
    ref = snapshot.reference;
    documentID = snapshot.documentID;
    Map<String, dynamic> map = snapshot.data;
    id = map[kPostID];
    text = map[kText];
    userID = map[kUID];
    imageUrl = map[kImageUrl];
    date = map[kDate];
    likes = map[kLikes];
    comments = map[kComments];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      kPostID: id,
      kUID: userID,
      kDate: date,
      kLikes: likes,
      kComments: comments,
    };
    if (text != null) map[kText] = text;
    if (imageUrl != null) map[kImageUrl] = imageUrl;

    return map;
  }
}
