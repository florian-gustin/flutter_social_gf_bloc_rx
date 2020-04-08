import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_home.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_root.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_router.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets/my_bottom_bar.dart';

class HomePage extends StatelessWidget {
  Widget showPage(int index, User user) {
    switch (index) {
      case 0:
        return BlocRouter().feed(user: user);
      case 1:
        return BlocRouter().users(user: user);
      case 2:
        return BlocRouter().notifications(user: user);
      default:
        return BlocRouter().profile(user: user);
    }
  }

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
                          backgroundColor: base,
                          body: showPage(snap.data, snapshot.data),
                          floatingActionButtonLocation:
                              FloatingActionButtonLocation.centerDocked,
                          floatingActionButton: FloatingActionButton(
                            onPressed: () {},
                            child: iWrite,
                            backgroundColor: pointer,
                          ),
                          bottomNavigationBar: MyBottomBar(items: [
                            MyBarItem(
                                icon: iHome,
                                onPressed: (() =>
                                    home.onBottomBarItemSelected(0)),
                                selected: home.index == 0),
                            MyBarItem(
                                icon: iFriends,
                                onPressed: (() =>
                                    home.onBottomBarItemSelected(1)),
                                selected: home.index == 1),
                            SizedBox(
                              height: 0,
                              width: 0,
                            ),
                            MyBarItem(
                                icon: iNotifications,
                                onPressed: (() =>
                                    home.onBottomBarItemSelected(2)),
                                selected: home.index == 2),
                            MyBarItem(
                                icon: iProfile,
                                onPressed: (() =>
                                    home.onBottomBarItemSelected(3)),
                                selected: home.index == 3),
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
