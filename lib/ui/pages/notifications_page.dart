import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_feed.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_notifications.dart';
import 'package:flutter_social_gf_bloc_rx/models/notif.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:flutter_social_gf_bloc_rx/ui/tiles/notif_tile.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifications = GetBloc.of<BlocNotifications>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: notifications.notifsStreams(),
      builder: (BuildContext context, snapshots) {
        if (snapshots.hasData) {
          final List<DocumentSnapshot> documents = snapshots.data.documents;
          print(documents.length);
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, index) {
              Notif notif = Notif(documents[index]);
              return NotifTile(
                  notif: notif, stream: notifications.notifTileStreams);
            },
          );
        } else {
          return Center(
            child: MyText(
              'None notifications',
              color: pointer,
              fontSize: 40.0,
            ),
          );
        }
      },
    );
  }
}
