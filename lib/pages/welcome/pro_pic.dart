import 'dart:io';

import 'package:audio_show/util/history.dart';
import 'package:audio_show/widgets/round_button.dart';
import 'package:audio_show/util/style.dart';
import 'package:audio_show/pages/home/home_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
//import 'package:firebase_picture_uploader/firebase_picture_uploader.dart';
import 'package:firebase_storage/firebase_storage.dart';
// ignore: must_be_immutable
class PickPhotoPage extends StatefulWidget {

  //List<String> userinfo;
  PickPhotoPage(List<String> userinfo);
  //FilePickerResult file;
  @override
  _PickPhotoState createState() => _PickPhotoState();


}
class _PickPhotoState extends State<PickPhotoPage>
{
  FilePickerResult file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          buildActionButton(context),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(
          top: 30,
          bottom: 60,
        ),
        child: Column(
          children: [
            buildTitle(),
            Spacer(
              flex: 1,
            ),
            buildContents(),
            Spacer(
              flex: 3,
            ),
            buildBottom(context),
          ],
        ),
      ),
    );
  }

  Widget buildActionButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: GestureDetector(
        onTap: () {
          History.pushPageReplacement(context, HomePage());

        },
        child: Text(
          'Skip',
          style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildTitle() {
    return Text(
      'Great! Now add a photo?',
      style: TextStyle(
        fontSize: 25,
      ),
    );
  }

  Widget buildContents() {
    return InkWell(
      onTap:()
      async {
        file = await FilePicker.platform.pickFiles(type:FileType.image);
        List<String> path =  file.paths;
        setState(() {
          new Container(
              child: new CircleAvatar(
                radius: 80.0,
                backgroundImage: ExactAssetImage(file.paths[0]),

              )

          );

        });

        //file.runtimeType;
      },
      child:new Center(
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


        );/*            new Container(
          height: 160.0,
          width: 160.0,
          decoration: new BoxDecoration(
            color: const Color(0xff7c94b6),
            image: new DecorationImage(
              image: new ExactAssetImage(path()),
              fit: BoxFit.cover,
            ),
            border:
            Border.all(color: Colors.red, width: 5.0),
            borderRadius:
            new BorderRadius.all(const Radius.circular(80.0)),
          ),
        )
      )
        Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(80),
      ),
      child: Icon(
        Icons.add_photo_alternate_outlined,
        size: 100,
        color: Colors.blueAccent,
      ),
    )*/



  }
  /*
  Widget previewImage(ImageSource source) {
    // ignore: invalid_use_of_visible_for_testing_member
    File imageFile = ImagePicker.platform as File;
    return Image.file(imageFile);
  }
*/

  Widget buildBottom(BuildContext context) {
    return RoundButton(
      color: Colors.blueAccent,
      minimumWidth: 230,
      disabledColor: Colors.blueAccent.withOpacity(0.3),
      onPressed: () {
        //FirebaseStorage _storage = FirebaseStorage.instance;
        //_pickSaveImage(imageId);
        //History.pushPageReplacement(context, HomePage());
        next(context);
        }
    ,
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            Icon(
              Icons.arrow_right_alt,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
next(BuildContext context)
{
  History.pushPageReplacement(context, HomePage());

}

String path()
{
  print(file.paths[0]);
  return file.paths[0];
}

  /*
  void _openCamera(BuildContext context)  async{
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera ,
    );
    setState(() {
      imageFile = pickedFile;
    });

  }
  void _openGallery(BuildContext context) async{
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery ,
    );
    setState(() {
      imageFile = pickedFile;
    });


  }
  */

}





