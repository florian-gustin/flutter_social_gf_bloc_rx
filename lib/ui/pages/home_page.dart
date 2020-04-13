import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_home.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_root.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_router.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/pages/feed_page.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets/my_bottom_bar.dart';

class HomePage extends StatelessWidget {
  Widget showPage(int index, User user) {
    switch (index) {
      case 1:
        return BlocRouter().users();
      case 2:
        return BlocRouter().notifications();
      case 3:
        return BlocRouter().profile(user: user);
      default:
        return BlocRouter().feed(user: myAccount);
    }
  }

  @override
  Widget build(BuildContext context) {
    final home = BlocProvider.of<BlocHome>(context);

    return StreamBuilder<User>(
      stream: home.streamUser,
      builder: (context, snapshot) {
        final user = snapshot.data;
        return (snapshot.hasData)
            ? StreamBuilder<int>(
                stream: home.streamIndex,
                builder: (ctx, snap) {
                  final index = snap.data;
                  return (snap.hasData)
                      ? Scaffold(
                          key: home.globalKey,
                          backgroundColor: base,
                          body: showPage(index, user),
                          floatingActionButtonLocation:
                              FloatingActionButtonLocation.centerDocked,
                          floatingActionButton: FloatingActionButton(
                            onPressed: () {
                              home.globalKey.currentState.showBottomSheet(
                                (context) => BlocRouter().newPost(),
                              );
                            },
                            child: iWrite,
                            backgroundColor: pointer,
                          ),
                          bottomNavigationBar: MyBottomBar(items: [
                            MyBarItem(
                                icon: iHome,
                                onPressed: (() =>
                                    home.onBottomBarItemSelected(0)),
                                selected: index == 0),
                            MyBarItem(
                                icon: iFriends,
                                onPressed: (() =>
                                    home.onBottomBarItemSelected(1)),
                                selected: index == 1),
                            SizedBox(
                              height: 0,
                              width: 0,
                            ),
                            MyBarItem(
                                icon: iNotifications,
                                onPressed: (() =>
                                    home.onBottomBarItemSelected(2)),
                                selected: index == 2),
                            MyBarItem(
                                icon: iProfile,
                                onPressed: (() =>
                                    home.onBottomBarItemSelected(3)),
                                selected: index == 3),
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
