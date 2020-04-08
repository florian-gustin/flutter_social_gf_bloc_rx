import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_root.dart';
import 'package:flutter_social_gf_bloc_rx/ui/pages/auth_page.dart';
import 'package:flutter_social_gf_bloc_rx/ui/pages/home_page.dart';

void main() {
  runApp(BlocProvider<BlocRoot>(
    builder: (_, bloc) => BlocRoot(),
    onDispose: (_, bloc) => bloc.dispose(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = GetBloc.of<BlocRoot>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StreamBuilder<FirebaseUser>(
        stream: bloc.onAuthStateChanged,
        builder: (context, snapshot) {
          return (snapshot.hasData) ? HomePage() : AuthPage();
        },
      ),
    );
  }
}
