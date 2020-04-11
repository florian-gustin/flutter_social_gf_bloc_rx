import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/services/firebase.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class BlocNotifications extends BlocBase {
  Firebase _firebase;

  BlocNotifications() {
    _firebase = Firebase();
  }

  Stream<QuerySnapshot> notifsStreams() => _firebase.dbNotifs
      .document(myAccount.uid)
      .collection('singleNotif')
      .snapshots();

  Stream<DocumentSnapshot> notifTileStreams(String path) =>
      _firebase.dbUsers.document(path).snapshots();

  @override
  void dispose() {
    fDisposingBlocOf('Bloc Notifications');
  }
}
