import 'package:audio_show/models/user.dart';
import 'package:audio_show/pages/welcome/pro_pic.dart';
import 'package:audio_show/pages/welcome/username.dart';
import 'package:audio_show/pages/welcome/welcome.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:audio_show/util/history.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:audio_show/pages/welcome/profileimage.dart';
//import 'HomePage.dart';


 class newUser extends StatelessWidget {
  final Userprofile user;



  const newUser({Key key, this.user}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new LoginPage(),
        routes: <String, WidgetBuilder>{
          '/loginpage' : (BuildContext context) => WelcomePage(),
          '/landpage' : (BuildContext context) => LoginPage(),
        }
    );
  }
}
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneNumberController = TextEditingController();
  //final _smsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String phoneNo, smsId, verificationId;


  Future<void> verifyPhone() async{
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId){
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]){
      this.verificationId = verId;
      smsCodeDialoge(context).then((value){
        print('Signed In');
      });
    };
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) async {
      await showDialog(
          context: context,
          builder: (context) =>
      new AlertDialog(
        title: new Text('Status'),
        content: Text(
            'Verified'),

        actions: <Widget>[
          new ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pop(); // dismisses only the dialog and returns nothing
              History.pushPage(context, UsernamePage([this.phoneNo]));
              //History.pushPage(context, PickPhotoPage());

            },
            child: new Text('OK'),
          ),
        ],
      ),
      );
    };
    final PhoneVerificationFailed verifyFailed = (FirebaseAuthException e) {
      print('${e.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 60),

      verificationCompleted: verifiedSuccess,

      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );

  }
  Future<bool> smsCodeDialoge(BuildContext context){
    return showDialog(context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text('Enter OTP'),
          content: TextField(

            onChanged: (value)  {
              this.smsId=SmsAutoFill().listenForCode as String;

              //this.smsId  = value;

            },
          ),
          contentPadding: EdgeInsets.all(10.0),
          actions: <Widget>[
            new TextButton(
                onPressed: (){
                  User currentUser= FirebaseAuth.instance.currentUser;

                    if(currentUser != null){
                      Navigator.of(context).pop();
                      History.pushPage(context, UsernamePage([this.phoneNo]));

                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UsernamePage()),
                      );*/

                    }
                    else{
                      Navigator.of(context).pop();
                      signIn(smsId);
                    }



                },
                child: Text('Done', style: TextStyle( color: Colors.blue),)),
        
        TextButton(
        onPressed: verifyPhone,

        child: Text("Didn't get my code!Resend", style: TextStyle(color: Colors.white),),
        style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
        ))
          ],
        );
      },
    );
  }

  Future<void> signIn(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    await FirebaseAuth.instance.signInWithCredential(credential)
        .then((user){

      Navigator.of(context).pushReplacementNamed('/loginpage');
    }

    ).catchError((e){
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Sign In')
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          Text('Phone verification',style: TextStyle(fontSize: 20,color: Colors.blue),),
          /*
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
              ),
              onChanged: (value){
                this.phoneNo = "+91"+value;
              },
            ),
          ),*/
          Row(
              children: [
                CountryCodePicker(
                  initialSelection: 'IN',
                  showCountryOnly: false,
                  alignLeft: false,
                  padding: const EdgeInsets.all(8),
                  textStyle: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      onChanged: (value) {
                        _formKey.currentState.validate();
                        // this.phoneNo="+91"+this._phoneNumberController.toString();
                        print(this._phoneNumberController);
                        this.phoneNo="+91"+value;
                      },/*
                      validator: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            onSignUpButtonClick = null;
                          });
                        } else {
                          setState(()  {
                            onSignUpButtonClick = signUp();
                            print("Done");
                          });
                        }*/


                      controller: _phoneNumberController,
                      autocorrect: false,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(
                          fontSize: 20,
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],),
          SizedBox(height: 10.0),
         ElevatedButton(
            onPressed: verifyPhone,
            child: Text('Verify', style: TextStyle(color: Colors.white),),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
            )



          )

      ]),
    );
  }
}