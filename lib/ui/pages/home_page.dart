import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_root.dart';
import 'package:flutter_social_gf_bloc_rx/services/firebase.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final bloc = GetBloc.of<BlocRoot>(context);
//
//    bloc.signOut;

    return Center(
      child: Text('home'),
    );
  }
}
