import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/models/post.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/services/firebase.dart';
import 'package:flutter_social_gf_bloc_rx/ui/pages/feed_page.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:rxdart/rxdart.dart';

class BlocFeed extends BlocBase {
  User user;
  Firebase _firebase;

  BlocFeed({@required this.user}) {
    _firebase = Firebase();
  }

  void handleLike(Post post) => _firebase.addLike(post);
  void handleComment(DocumentReference ref, String text, String postAuthor) =>
      _firebase.addComment(ref, text, postAuthor);

  @override
  void dispose() {
    fDisposingBlocOf('Bloc Feed');
  }
}
