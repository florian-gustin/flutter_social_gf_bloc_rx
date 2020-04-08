import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_feed.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_profile.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile = GetBloc.of<BlocProfile>(context);

    return Center(
      child: MyText('feed'),
    );
  }
}
