import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:flutter_image_ppicker/image_picker_dialog.dart';
import 'package:audio_show/pages/welcome/imagepickerdialog.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHandler {
  ImagePickerDialog imagePicker;
  AnimationController _controller;
  ImagePickerListener _listener;

  ImagePickerHandler(this._listener,this._controller);

  openCamera() async {
    imagePicker.dismissDialog();
    // ignore: invalid_use_of_visible_for_testing_member
    var image = await ImagePicker.platform.pickImage(source: ImageSource.camera);
    cropImage(image as File);
  }

  openGallery() async {
    imagePicker.dismissDialog();
    // ignore: invalid_use_of_visible_for_testing_member
    var image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    cropImage(image as File);
  }

  void init(BuildContext context) {
    imagePicker = new ImagePickerDialog(this,_controller);
    imagePicker.initState();
    print(_controller);
    print(imagePicker);
    imagePicker.getImage(context);
  }

  Future cropImage(File image) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio:1/1 as CropAspectRatio,
      maxWidth: 512,
      maxHeight: 512,
    );
    _listener.userImage(croppedFile);
  }
/*
  showDialog(BuildContext context,ImagePickerHandler) {
    imagePicker.getImage(context);
  }*/
}

abstract class ImagePickerListener {
  userImage(File _image);
}