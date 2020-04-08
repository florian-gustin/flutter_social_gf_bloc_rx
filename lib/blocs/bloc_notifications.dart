import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class BlocNotifications extends BlocBase {
  User user;

  BlocNotifications({@required this.user}) {}

  @override
  void dispose() {
    fDisposingBlocOf('Bloc Notifications');
  }
}
