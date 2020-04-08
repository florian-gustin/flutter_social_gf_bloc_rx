import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_home.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_root.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_router.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets/my_bottom_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final root = GetBloc.of<BlocRoot>(context);
//
//    root.signOut();

    final home = GetBloc.of<BlocHome>(context);

    return StreamBuilder<User>(
      stream: home.streamUser,
      builder: (context, snapshot) {
        return (snapshot.hasData)
            ? StreamBuilder(
                stream: home.streamIndex,
                builder: (ctx, snap) {
                  return (snapshot.hasData)
                      ? Scaffold(
                          key: home.globalKey,
                          body: Center(
                            child: Text(snapshot.data.toString()),
                          ),
                          bottomNavigationBar: MyBottomBar(items: [
                            MyBarItem(
                                icon: Icon(Icons.android),
                                onPressed: (() =>
                                    home.onBottomBarItemSelected(0)),
                                selected: home.index == 0),
                            MyBarItem(
                                icon: Icon(Icons.android),
                                onPressed: (() =>
                                    home.onBottomBarItemSelected(1)),
                                selected: home.index == 1),
                            MyBarItem(
                                icon: Icon(Icons.android),
                                onPressed: (() =>
                                    home.onBottomBarItemSelected(2)),
                                selected: home.index == 2),
                          ]),
                        )
                      : SizedBox();
                },
              )
            : BlocRouter().loading();
      },
    );
  }
}
