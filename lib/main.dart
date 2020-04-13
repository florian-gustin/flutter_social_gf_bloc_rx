import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_root.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_router.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

void main() {
  runApp(
    BlocRouter().root(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final root = BlocProvider.of<BlocRoot>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        canvasColor: Colors.transparent,
        primaryColor: base,
        accentColor: baseAccent,
      ),
      home: StreamBuilder<FirebaseUser>(
        stream: root.onAuthStateChanged,
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.active)
              ? (snapshot.hasData)
                  ? BlocRouter().home(userID: snapshot.data.uid)
                  : BlocRouter().auth()
              : BlocRouter().loading();
        },
      ),
    );
  }
}
