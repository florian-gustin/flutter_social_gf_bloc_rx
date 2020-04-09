import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/services/firebase.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:rxdart/rxdart.dart';

class BlocHome extends BlocBase {
  final String userID;
  GlobalKey<ScaffoldState> globalKey;
  User user;
  Firebase _firebase;
  int index;

  BehaviorSubject<int> _subjectIndex = BehaviorSubject<int>();
  Stream<int> get streamIndex => _subjectIndex.stream;
  Sink<int> get sinkIndex => _subjectIndex.sink;

  BehaviorSubject<User> _subjectUser = BehaviorSubject<User>();
  Stream<User> get streamUser => _subjectUser.stream;
  Sink<User> get sinkUser => _subjectUser.sink;

  BlocHome({@required this.userID}) {
    globalKey = GlobalKey<ScaffoldState>();
    index = 0;
    sinkIndex.add(index);
    _firebase = Firebase();
    // return current user
    _firebase.dbUsers.document(userID).snapshots().listen((documents) {
      user = User(documents);
      // assign to stream
      sinkUser.add(user);
    });
  }

  void onBottomBarItemSelected(int selected) {
    index = selected;
    syncIndex();
  }

  void syncIndex() => sinkIndex.add(index);
  void syncUser() => sinkUser.add(user);

  @override
  void dispose() {
    _subjectIndex.close();
    _subjectUser.close();
    fDisposingBlocOf('Bloc Home');
  }
}
