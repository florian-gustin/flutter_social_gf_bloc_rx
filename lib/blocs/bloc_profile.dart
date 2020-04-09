import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/services/firebase.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:rxdart/rxdart.dart';

class BlocProfile extends BlocBase {
  User user;
  Firebase _firebase;
  bool isMe;
  ScrollController scrollController;
  double expanded;
  bool get showTitle {
    return scrollController.hasClients &&
        scrollController.offset > expanded - kToolbarHeight;
  }

  BehaviorSubject<ScrollController> _subjectScrollController =
      BehaviorSubject<ScrollController>();
  Stream<ScrollController> get streamScrollController =>
      _subjectScrollController.stream;
  Sink<ScrollController> get sinkScrollController =>
      _subjectScrollController.sink;

  BlocProfile({@required this.user, this.isMe}) {
    scrollController = ScrollController();
    syncScrollController();
    _firebase = Firebase();
    expanded = 200.0;
  }
  // need these two functions and a stream to bypass
  // the actual usage of ScrollController Widget
  // for listening in BLoC Pattern
  void scrollControllerListener() {
    scrollController
      ..addListener(() {
        syncScrollController();
      });
  }

  void syncScrollController() => sinkScrollController.add(scrollController);

  Stream<QuerySnapshot> get allPostsFrom => _firebase.allPostsFrom(user.uid);

  @override
  void dispose() {
    scrollController.dispose();
    _subjectScrollController.close();
    fDisposingBlocOf('Bloc Profile');
  }
}
