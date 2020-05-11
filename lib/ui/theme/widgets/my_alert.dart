import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class MyAlert {
  FlatButton closeButton(BuildContext ctx, String text) {
    return FlatButton(
      onPressed: () => Navigator.pop(ctx),
      child: MyText(
        text,
        color: pointer,
      ),
    );
  }

  FlatButton logOutButton(BuildContext ctx, Function onPressed) {
    return FlatButton(
      onPressed: onPressed,
      child: MyText(
        'OK',
        color: Colors.blue,
      ),
    );
  }

  Future<void> logOut(BuildContext context, Function onPressed) async {
    MyText title = MyText(
      'Would you like to log out ?',
      color: base,
    );
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return (Theme.of(context).platform == TargetPlatform.iOS)
              ? CupertinoAlertDialog(
                  title: title,
                  actions: <Widget>[
                    closeButton(ctx, 'NO'),
                    logOutButton(ctx, onPressed)
                  ],
                )
              : AlertDialog(
                  title: title,
                  actions: <Widget>[
                    closeButton(ctx, 'NO'),
                    logOutButton(ctx, onPressed)
                  ],
                );
        });
  }

  Future<void> updateUserAlert(
    BuildContext context, {
    @required TextEditingController firstname,
    @required TextEditingController lastname,
    @required TextEditingController description,
    @required User user,
    @required Function onValidation,
  }) async {
    MyTextField firstnameTF = MyTextField(
      controller: firstname,
      hint: user.firstname,
    );

    MyTextField lastnameTF = MyTextField(
      controller: lastname,
      hint: user.lastname,
    );

    MyTextField descriptionTF = MyTextField(
      controller: description,
      hint: user.description,
    );

    MyText title = MyText(
      'Edit user informations',
      color: pointer,
    );

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return (Theme.of(context).platform == TargetPlatform.iOS)
              ? CupertinoAlertDialog(
                  title: title,
                  content: Column(
                    children: <Widget>[firstnameTF, lastnameTF, descriptionTF],
                  ),
                  actions: <Widget>[
                    closeButton(ctx, 'Cancel'),
                    FlatButton(
                        onPressed: onValidation,
                        child: MyText(
                          'OK',
                          color: Colors.blue,
                        ))
                  ],
                )
              : AlertDialog(
                  title: title,
                  content: Column(
                    children: <Widget>[firstnameTF, lastnameTF, descriptionTF],
                  ),
                  actions: <Widget>[
                    closeButton(ctx, 'Cancel'),
                    FlatButton(
                        onPressed: onValidation,
                        child: MyText(
                          'OK',
                          color: Colors.blue,
                        ))
                  ],
                );
        });
  }

  Future<void> error(BuildContext context, String error) async {
    MyText title = MyText(
      'Error',
      color: Colors.black,
    );
    MyText subtitle = MyText(
      error,
      color: Colors.black,
    );

    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext ctx) {
          return (Theme.of(context).platform == TargetPlatform.iOS)
              ? CupertinoAlertDialog(
                  title: title,
                  content: MyPadding(
                    child: subtitle,
                  ),
                  actions: <Widget>[closeButton(ctx, 'OK')],
                )
              : AlertDialog(
                  title: title,
                  content: MyPadding(
                    child: subtitle,
                  ),
                  actions: <Widget>[closeButton(ctx, 'OK')],
                );
        });
  }
}
