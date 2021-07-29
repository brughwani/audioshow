import 'dart:io';

import 'package:audio_show/pages/welcome/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends StatefulWidget
{
/*
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker=new ImagePicker(this._controller);
    imagePicker.init();

  }
*/
  @override
  _ProfileImageState createState() => _ProfileImageState();
    // TODO: implement createState



}

class _ProfileImageState extends State<ProfileImage> with SingleTickerProviderStateMixin{
  @override

  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;
  @override
  void initState() {
    super.initState();
     _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );


    imagePicker=new ImagePickerHandler(this.userImage(_image),_controller);


  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("One last step,Choose a Photo",
          style: new TextStyle(
              color: Colors.white
          ),
        ),
      ),
      body: new GestureDetector(
        onTap: () {
          print(imagePicker);
          imagePicker.imagePicker.initState();
          },
        child: new Center(
          child: _image == null
              ? new Stack(
            children: <Widget>[

              new Center(
                child: new CircleAvatar(
                  radius: 80.0,
                  backgroundColor: const Color(0xFFFFFF),
                  child: Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 100,
                    color: Colors.blueAccent,
                  ),
                )
          ,
              ),
              new Center(
                child: new Image.asset("assets/photo_camera.png"),
              ),

            ],
          )
              : new Container(
            height: 160.0,
            width: 160.0,
            decoration: new BoxDecoration(
              color: const Color(0xff7c94b6),
              image: new DecorationImage(
                image: new ExactAssetImage(_image.path),
                fit: BoxFit.cover,
              ),
              border:
              Border.all(color: Colors.red, width: 5.0),
              borderRadius:
              new BorderRadius.all(const Radius.circular(80.0)),
            ),
          ),
        ),
      ),

    );
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
}


