// ignore: avoid_web_libraries_in_flutter
//import 'dart:html';

//import 'dart:html';

import 'package:audio_show/models/user.dart';
import 'package:audio_show/pages/home/home_page.dart';
import 'package:audio_show/pages/lobby/lobby_page.dart';
import 'package:audio_show/pages/welcome/phone.dart';
import 'package:audio_show/pages/welcome/pro_pic.dart';
import 'package:audio_show/util/history.dart';
import 'package:audio_show/widgets/round_button.dart';
import 'package:audio_show/util/style.dart';
//import 'package:untitled/pages/welcome/pick_photo_page.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class UsernamePage extends StatefulWidget {
   List<String> previousFields;
  UsernamePage(this.previousFields);

  //const UsernamePage({Key key, this.previousFields}) : super(key: key);

  @override
  _UsernamePageState createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  TextEditingController _userNameController = TextEditingController();
  //final _userNameformKey = GlobalKey<FormState>();
  static GlobalKey<FormState> _userNameformKey = new GlobalKey<FormState>();
  String username;

  Function onNextButtonClick;
  //CollectionReference users = FirebaseFirestore.instance.collection('users');
  List<String> usernameinfo=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(
          top: 30,
          bottom: 60,
        ),
        child: Column(
          children: [
            buildTitle(),
            SizedBox(
              height: 50,
            ),
            buildForm(),
            Spacer(),
            buildBottom(),
          ],
        ),
      ),
    );
  }

  Widget buildTitle() {
    return Text(
      'Pick a username',
      style: TextStyle(
        fontSize: 25,
      ),
    );
  }



  Widget buildForm() {
    return FutureBuilder(

        future: usernameCheck(context,this.username),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot)  {
          if (snapshot.connectionState!=ConnectionState.done) { // not loaded

            return  CircularProgressIndicator();
          }
          else if (snapshot.hasError) {
            return ErrorWidget(context);
          }
          else  {
            bool valid = snapshot.hasData;
            Future<bool> valid1;
            return Container(
              width: 330,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Form(
                key: _userNameformKey,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    _userNameformKey.currentState.validate();
                    setState(() {
                       valid1=usernameCheck(context,_userNameController.toString());
                    });

                  },
                  validator: (value) {
                    if (value.isEmpty || valid1==false) {
                      setState(() {
                        onNextButtonClick = null;
                        print("1");
                      });
                    }
                    else if(valid1==true && value.isNotEmpty) {
                      print("2");
                      setState(() {
                        onNextButtonClick=next();
                        this.username = value;
                        this.usernameinfo.addAll(widget.previousFields);
                        this.usernameinfo.add(value);

                      }
                      );

                      return null;
                    }
                    return null;
                  },
                  controller: _userNameController,
                  autocorrect: false,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: '@username',
                    hintStyle: TextStyle(
                      fontSize: 20,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          }
        }
    );
  }




  Widget buildBottom() {
    return RoundButton(
      color: Style.AccentBlue,
      minimumWidth: 230,
      disabledColor: Style.AccentBlue.withOpacity(0.3),
      onPressed:()
      {
            // ignore: unnecessary_statements
            onNextButtonClick;
            print(onNextButtonClick);
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
      )
    );
  }

  next()  {


     /* if () {
        // username exists


      }
      else if (_userNameformKey.currentState.validate()) {
        // save the username or something


      }
*/

    History.pushPageUntil(context, PickPhotoPage(this.usernameinfo));

  }
}
// ignore: missing_return
Future<bool> usernameCheck(BuildContext context,String username)
async {
  /*final result = await FirebaseFirestore.instance
      .collection('Consumers')
      .where('Username', isEqualTo: username).get();
  return result.docs.isEmpty;*/
  if(username!=null) {
  final QuerySnapshot result = await FirebaseFirestore.instance
      .collection('Consumers').where('Username', isEqualTo: username).get();

  //converts results to a list of documents
  final List<DocumentSnapshot> documents = result.docs;

  //checks the length of the document to see if its
  //greater than 0 which means the username has already been taken

    if (documents.length > 0) {
      //print(username + ' is already taken choose  another name');
      showDialog(
        context: context,
        builder: (context) =>
        new AlertDialog(
          title: new Text('Taken'),
          content: Text(username + ' is already taken choose  another name'),
          actions: <Widget>[
            new ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pop(); // dismisses only the dialog and returns nothing
              },
              child: new Text('OK'),
            ),
          ],
        ),
      );
      return false;
    }
    else {
      return true;
    }
  }
}

// ignore: non_constant_identifier_names, missing_return
Widget ErrorWidget(BuildContext context)
{
  showDialog(
    context: context,
    builder: (context) =>
    new AlertDialog(
      title: new Text('ERROR'),
      content: Text(
          'Something went wrong'),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true)
                .pop(); // dismisses only the dialog and returns nothing
          },
          child: new Text('OK'),
        ),
      ],
    ),
  );
}
