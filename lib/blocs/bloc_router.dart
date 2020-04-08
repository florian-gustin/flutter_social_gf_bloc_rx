import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_home.dart';
import 'package:flutter_social_gf_bloc_rx/main.dart';
import 'package:flutter_social_gf_bloc_rx/ui/pages/auth_page.dart';
import 'package:flutter_social_gf_bloc_rx/ui/pages/home_page.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'base.dart';
import 'bloc_root.dart';

class BlocRouter {
  BlocProvider root() => BlocProvider<BlocRoot>(
      builder: (_, bloc) => BlocRoot(),
      onDispose: (_, bloc) => bloc.dispose(),
      child: MyApp());

  Widget loading() => MyLoadingPage();
  Widget auth() => AuthPage();

  BlocProvider home({@required String userID}) => BlocProvider<BlocHome>(
        builder: (_, bloc) => BlocHome(userID: userID),
        onDispose: (_, bloc) => bloc.dispose(),
        child: HomePage(),
      );
}
