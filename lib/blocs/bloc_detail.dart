import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/models/post.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/services/firebase.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class BlocDetail extends BlocBase {
  User user;
  Post post;
  Firebase _firebase;

  BlocDetail({
    @required this.user,
    @required this.post,
  }) {
    _firebase = Firebase();
  }

  Stream commentTileStream(String path) =>
      _firebase.dbUsers.document(path).snapshots();

  @override
  void dispose() {
    fDisposingBlocOf('Bloc Detail');
  }
}
