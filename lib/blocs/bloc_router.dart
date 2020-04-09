import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_home.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_new_post.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_profile.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_profile.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_users.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_users.dart';
import 'package:flutter_social_gf_bloc_rx/main.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/pages/auth_page.dart';
import 'package:flutter_social_gf_bloc_rx/ui/pages/feed_page.dart';
import 'package:flutter_social_gf_bloc_rx/ui/pages/home_page.dart';
import 'package:flutter_social_gf_bloc_rx/ui/pages/new_post_page.dart';
import 'package:flutter_social_gf_bloc_rx/ui/pages/notifications_page.dart';
import 'package:flutter_social_gf_bloc_rx/ui/pages/notifications_page.dart';
import 'package:flutter_social_gf_bloc_rx/ui/pages/notifications_page.dart';
import 'package:flutter_social_gf_bloc_rx/ui/pages/profile_page.dart';
import 'package:flutter_social_gf_bloc_rx/ui/pages/users_page.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'base.dart';
import 'bloc_feed.dart';
import 'bloc_notifications.dart';
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

  BlocProvider feed({@required User user}) => BlocProvider<BlocFeed>(
        builder: (_, bloc) => BlocFeed(user: user),
        onDispose: (_, bloc) => bloc.dispose(),
        child: FeedPage(),
      );

  BlocProvider users({@required User user}) => BlocProvider<BlocUsers>(
        builder: (_, bloc) => BlocUsers(user: user),
        onDispose: (_, bloc) => bloc.dispose(),
        child: UsersPage(),
      );

  BlocProvider notifications({@required User user}) =>
      BlocProvider<BlocNotifications>(
        builder: (_, bloc) => BlocNotifications(user: user),
        onDispose: (_, bloc) => bloc.dispose(),
        child: NotificationsPage(),
      );

  BlocProvider profile({@required User user}) => BlocProvider<BlocProfile>(
        builder: (_, bloc) => BlocProfile(user: user),
        onDispose: (_, bloc) => bloc.dispose(),
        child: ProfilePage(),
      );

  BlocProvider newPost() => BlocProvider<BlocNewPost>(
        builder: (_, bloc) => BlocNewPost(),
        onDispose: (_, bloc) => bloc.dispose(),
        child: NewPostPage(),
      );
}
