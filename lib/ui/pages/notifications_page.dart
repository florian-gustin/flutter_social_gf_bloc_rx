import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_feed.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_notifications.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifications = GetBloc.of<BlocNotifications>(context);

    return Center(
      child: MyText('no'),
    );
  }
}
