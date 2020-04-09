import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/blocs/base.dart';
import 'package:flutter_social_gf_bloc_rx/services/firebase.dart';
import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

class BlocNewPost extends BlocBase {
  Firebase _firebase;
  TextEditingController textEditingController;
  File imageTaken;

  BehaviorSubject<File> _subjectImageTaken = BehaviorSubject<File>();
  Stream<File> get streamImageTaken => _subjectImageTaken.stream;
  Sink<File> get sinkImageTaken => _subjectImageTaken.sink;

  BlocNewPost() {
    _firebase = Firebase();
    textEditingController = TextEditingController();
  }

  Future<void> takePicture(ImageSource source) async {
    File image = await ImagePicker.pickImage(
        source: source, maxWidth: 500.0, maxHeight: 500.0);
    imageTaken = image;
    syncImageTaken();
  }

  Stream takePictureAsStream(ImageSource source) {
    ImagePicker.pickImage(source: source).asStream().listen((File file) {
      imageTaken = file;
      syncImageTaken();
    });
  }

  void addPostInFirebase(BuildContext context, String uid) {
    hideKeyboard(context);
    popContext(context);
    if (imageTaken != null ||
        (textEditingController.text != null &&
            textEditingController.text != '')) {
      _firebase.addPost(uid, textEditingController.text, imageTaken);
    }
  }

  void syncImageTaken() => sinkImageTaken.add(imageTaken);

  @override
  void dispose() {
    _subjectImageTaken.close();
    textEditingController.dispose();
    fDisposingBlocOf('Bloc New Post');
  }
}
