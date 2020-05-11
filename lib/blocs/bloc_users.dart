import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/services/firebase.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class BlocUsers extends BlocBase {
  Firebase _firebase;

  Stream<QuerySnapshot> get allUsers => _firebase.dbUsers.snapshots();

  BlocUsers() {
    _firebase = Firebase();
  }

  void upsertFollow(User other, User me) => _firebase.upsertFollow(other, me);

  @override
  void dispose() {
    fDisposingBlocOf('Bloc Users');
  }
}
