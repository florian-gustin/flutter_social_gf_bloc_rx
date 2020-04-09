import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_root.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class AuthPage extends StatelessWidget {
  Widget authSection(int index, context, bloc) {
    return Column(
      children: <Widget>[
        MyPadding(
          child: Card(
            elevation: 7.5,
            color: white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: listItems((index == 0), bloc),
              ),
            ),
          ),
          top: 15.0,
          bottom: 15.0,
          left: 30.0,
          right: 30.0,
        ),
        MyPadding(
          top: 15.0,
          bottom: 15.0,
          child: MyGradientButton(
            onPressed: () {
              bloc.authConnect((index == 1), context);
            },
            text: (index == 1) ? 'OK' : 'Register',
          ),
        ),
      ],
    );
  }

  List<Widget> listItems(bool exist, bloc) {
    List<Widget> l = [];

    if (exist) {
      l.add(MyTextField(
        controller: bloc.firstname,
        hint: 'Enter your first name',
      ));
      l.add(MyTextField(
        controller: bloc.lastname,
        hint: 'Enter your last name',
      ));
    }

    l.add(MyTextField(
      controller: bloc.mail,
      hint: 'Enter your email address',
      type: TextInputType.emailAddress,
    ));
    l.add(MyTextField(
      controller: bloc.pwd,
      hint: 'Enter your password',
      obscure: true,
    ));

    return l;
  }

  @override
  Widget build(BuildContext context) {
    final root = GetBloc.of<BlocRoot>(context);

    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          // notification received
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: InkWell(
            child: Container(
              height: (MediaQuery.of(context).size.height >= 650)
                  ? MediaQuery.of(context).size.height
                  : 650.0,
              width: MediaQuery.of(context).size.width,
              decoration: MyGradient(
                startColor: base,
                endColor: baseAccent,
              ),
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    MyPadding(
                      child: Image(
                        height: 100,
                        image: logoImage,
                      ),
                    ),
                    MyPadding(
                      child: MyMenuAuth(
                          item1: 'Sign In',
                          item2: 'Sign Up',
                          pageController: root.pageController),
                      top: 20.0,
                      bottom: 20.0,
                    ),
                    Expanded(
                      flex: 2,
                      child: PageView(
                        controller: root.pageController,
                        children: <Widget>[
                          authSection(1, context, root),
                          authSection(0, context, root),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // dismissing keyboard
            onTap: () => hideKeyboard(context),
          ),
        ),
      ),
    );
  }
}
