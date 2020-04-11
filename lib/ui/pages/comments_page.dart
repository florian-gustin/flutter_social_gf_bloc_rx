import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_detail.dart';
import 'package:flutter_social_gf_bloc_rx/models/post.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:flutter_social_gf_bloc_rx/ui/pages/detail_page.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class CommentsPage extends StatelessWidget {
  final User user;
  final Post post;
  final Function onSubmit;

  const CommentsPage({
    Key key,
    @required this.user,
    @required this.post,
    @required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      backgroundColor: base,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {
                  hideKeyboard(context);
                },
                child: BlocProvider<BlocDetail>(
                    builder: (_, bloc) => BlocDetail(post: post, user: user),
                    onDispose: (_, bloc) => bloc.dispose(),
                    child: DetailPage()),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1.0,
              color: baseAccent,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 75.0,
              color: base,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width - 100.0,
                    child: MyTextField(
                      controller: controller,
                      hint: 'Write a comment...',
                    ),
                  ),
                  IconButton(
                      icon: iSend,
                      onPressed: () {
                        hideKeyboard(context);
                        if (controller.text != null && controller.text != '') {
                          onSubmit(post.ref, controller.text, post.userID);
                        }
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
