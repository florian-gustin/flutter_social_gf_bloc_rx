import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class Notif {
  String text, date, userID, type;
  DocumentReference ref, notifRef;
  bool watched;

  Notif(DocumentSnapshot documentSnapshot) {
    notifRef = documentSnapshot.reference;
    Map<String, dynamic> map = documentSnapshot.data;
    text = map[kText];
    date = fDate(map[kDate]);
    userID = map[kUID];
    ref = map[kRef];
    watched = map[kWatched];
    type = map[kType];
  }
}
