import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'my_constants.dart';

class MyMenuAuth extends StatelessWidget {
  final String item1;
  final String item2;
  final PageController pageController;

  const MyMenuAuth({
    Key key,
    @required this.item1,
    @required this.item2,
    @required this.pageController,
  }) : super(key: key);

  Expanded itemButton(String name) {
    return Expanded(
      child: FlatButton(
        onPressed: () {
          int page = (pageController.page == 0.0) ? 1 : 0;
          pageController.animateToPage(
            page,
            duration: Duration(milliseconds: 500),
            curve: Curves.decelerate,
          );
        },
        child: Text(name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          color: pointer,
          borderRadius: BorderRadius.all(
            Radius.circular(
              25.0,
            ),
          ),
        ),
        child: CustomPaint(
          painter: MyPainter(pageController: pageController),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              itemButton(item1),
              itemButton(item2),
            ],
          ),
        ));
  }
}
