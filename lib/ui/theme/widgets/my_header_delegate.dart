import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  User user;
  Function callback;
  bool scrolled;

  MyHeaderDelegate({
    @required this.user,
    @required this.callback,
    @required this.scrolled,
  }) {}

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 5.0,
      ),
      padding: EdgeInsets.all(10.0),
      color: baseAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          (scrolled)
              ? Container(
                  width: 0.0,
                  height: 0.0,
                )
              : MyText('${user.firstname} ${user.lastname}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MyImageProfile(
                url: user.imageUrl,
                onPressed: () {},
              ),
              MyText((user?.description ?? 'None description')),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1.0,
            color: base,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              InkWell(
                child: MyText('Followers : ${user.followers.length}'),
              ),
              InkWell(
                child: MyText('Following : ${user.following.length - 1}'),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => (scrolled) ? 150.0 : 200.0;

  @override
  double get minExtent => (scrolled) ? 150.0 : 200.0;

  @override
  bool shouldRebuild(MyHeaderDelegate oldDelegate) =>
      (scrolled != oldDelegate.scrolled || user != oldDelegate.user);
}
