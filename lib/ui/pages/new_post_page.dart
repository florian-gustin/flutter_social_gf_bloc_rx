import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_home.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/bloc_new_post.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:image_picker/image_picker.dart';

class NewPostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newPost = GetBloc.of<BlocNewPost>(context);
    final home = GetBloc.of<BlocHome>(context);

    return Container(
      color: base,
      height: MediaQuery.of(context).size.height * 0.75,
      child: Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: InkWell(
          onTap: () => hideKeyboard(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MyPadding(
                child: MyText(
                  'Write something...',
                  color: baseAccent,
                  fontSize: 30.0,
                ),
                top: 25.0,
              ),
              MyPadding(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.0,
                  color: baseAccent,
                ),
              ),
              MyPadding(
                child: MyTextField(
                  controller: newPost.textEditingController,
                  hint: 'Say something',
                  icon: iWrite,
                ),
                top: 25.0,
                right: 25.0,
                left: 25.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      IconButton(
                          icon: iCam,
                          onPressed: () {
                            newPost.takePictureAsStream(ImageSource.camera);
                          }),
                      IconButton(
                          icon: iGallery,
                          onPressed: () {
                            newPost.takePictureAsStream(ImageSource.gallery);
                          }),
                    ],
                  ),
                  Container(
                    width: 75.0,
                    height: 75.0,
                    child: StreamBuilder<File>(
                      stream: newPost.streamImageTaken,
                      builder: (ctx, snapImage) {
                        return (snapImage.hasData)
                            ? Image.file(snapImage.data)
                            : MyText(
                                'None image',
                                fontSize: 13.0,
                                color: baseAccent,
                              );
                      },
                    ),
                  ),
                ],
              ),
              MyGradientButton(
                  onPressed: () =>
                      newPost.addPostInFirebase(context, home.user.uid),
                  text: 'Publish')
            ],
          ),
        ),
      ),
    );
  }
}
