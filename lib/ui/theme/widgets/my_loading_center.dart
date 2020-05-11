import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class MyLoadingCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyText(
        'Loading...',
        fontSize: 40.0,
        color: baseAccent,
      ),
    );
  }
}
