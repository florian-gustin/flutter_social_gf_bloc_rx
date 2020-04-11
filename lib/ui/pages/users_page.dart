import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_feed.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_home.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_users.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:flutter_social_gf_bloc_rx/ui/tiles/user_tile.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = GetBloc.of<BlocUsers>(context);
    final home = GetBloc.of<BlocHome>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: users.allUsers,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
        if (snap.hasData) {
          final documents = snap.data.documents;
          return NestedScrollView(
            headerSliverBuilder: (_, bool scrolled) {
              return [MySliverAppBar(title: 'Users List', image: eventImage)];
            },
            body: ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemBuilder: (ctx, index) {
                User user = User(documents[index]);
                return UserTile(
                  user: user,
                  me: home.user,
                  onPressedFollow: () => users.upsertFollow(user, home.user),
                );
              },
              itemCount: documents.length,
            ),
          );
        } else {
          return MyLoadingCenter();
        }
      },
    );
  }
}
