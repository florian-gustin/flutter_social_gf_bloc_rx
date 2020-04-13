import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_home.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_new_post.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_profile.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_profile.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_users.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_users.dart';
import 'package:flutter_social_gf_bloc_rx/main.dart';
import 'package:flutter_social_gf_bloc_rx/models/post.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/pages/auth_page.dart';
import 'package:flutter_social_gf_bloc_rx/ui/pages/comments_page.dart';
import 'package:flutter_social_gf_bloc_rx/ui/pages/detail_page.dart';
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
import 'bloc_detail.dart';
import 'bloc_feed.dart';
import 'bloc_notifications.dart';
import 'bloc_root.dart';

class BlocRouter {
  BlocProvider root() =>
      BlocProvider<BlocRoot>(blocBuilder: () => BlocRoot(), child: MyApp());

  Widget loading() => MyLoadingPage();
  Widget auth() => AuthPage();

  BlocProvider home({@required String userID}) => BlocProvider<BlocHome>(
        blocBuilder: () => BlocHome(userID: userID),
        child: HomePage(),
      );

  BlocProvider feed({@required User user}) => BlocProvider<BlocFeed>(
        blocBuilder: () => BlocFeed(user: user),
        child: FeedPage(),
      );

  BlocProvider users() => BlocProvider<BlocUsers>(
        blocBuilder: () => BlocUsers(),
        child: UsersPage(),
      );

  BlocProvider notifications() => BlocProvider<BlocNotifications>(
        blocBuilder: () => BlocNotifications(),
        child: NotificationsPage(),
      );

  BlocProvider profile({@required User user}) => BlocProvider<BlocProfile>(
        blocBuilder: () => BlocProfile(user: user),
        child: ProfilePage(),
      );

  BlocProvider newPost() => BlocProvider<BlocNewPost>(
        blocBuilder: () => BlocNewPost(),
        child: NewPostPage(),
      );

  BlocProvider detail({@required Post post, @required User user}) =>
      BlocProvider<BlocDetail>(
          blocBuilder: () => BlocDetail(post: post, user: user),
          child: DetailPage());

  Future<dynamic> comments(
          {@required BuildContext context,
          @required User user,
          @required Post post,
          @required Function onSubmit}) =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => CommentsPage(
                    onSubmit: onSubmit,
                    user: user,
                    post: post,
                  )));
}
