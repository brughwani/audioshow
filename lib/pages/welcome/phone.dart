import 'package:firebase_auth/firebase_auth.dart';
import 'package:audio_show/pages/welcome/sms_screen.dart';
import 'package:audio_show/util/history.dart';
import 'package:audio_show/widgets/round_button.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:audio_show/util/style.dart';
//import 'package:untitled/pages/welcome/invitation_page.dart';
import 'package:flutter/material.dart';
import 'package:audio_show/pages/welcome/username.dart';
//import 'package:flutter_signin_button/flutter_signin_button.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//import 'package:untitled/pages/welcome/sms_screen.dart';
import 'authenticate.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audio_show/models/user.dart';

// ignore: camel_case_types
abstract class newUser extends StatelessWidget {
  final Userprofile user;



  const newUser({Key key, this.user}) : super(key: key);

}
/*
Map<String, WidgetBuilder> routes = {
  '/audio_show/pages/welcome/sms_screen.dart': (context) => SmsScreen()
};*/
bool verification_status=false;

class  PhoneNumberPage extends StatefulWidget {
  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

 class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final _phoneNumberController = TextEditingController();
  final _smsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Function onSignUpButtonClick;
/*
  String verificationId;

  Future<void> verifyPhone(phoneNumber) async {
    // ignore: non_constant_identifier_names
    final PhoneVerificationCompleted verified = (AuthCredential AuthResult) {
      AuthService().signIn(context, AuthResult);
    };
    print("1");
    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };
    print("1");
    final PhoneCodeSent smsSent = (String verId, [int forceResend])  {
      this.verificationId = verId;

/*
      Navigator.of(context)
          .pushNamed('/audio_show/pages/welcome/sms_screen.dart',
          arguments: this.verificationId);
    //  Navigator.push(context,new MaterialPageRoute(
      //    builder: (context) =>new SmsScreen()),arguments: this.verificationId);
    */};
      print("2");
      final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
        this.verificationId = verId;
      };
      print("3");
      await FirebaseAuth.instance.verifyPhoneNumber(

        /// Make sure to prefix with your country code
          phoneNumber: phoneNumber,

          ///No duplicated SMS will be sent out upon re-entry (before timeout).
          timeout: const Duration(seconds: 60),

          /// If the SIM (with phoneNumber) is in the current device this function is called.
          /// This function gives `AuthCredential`. Moreover `login` function can be called from this callback
          /// When this function is called there is no need to enter the OTP, you can click on Login button to sigin directly as the device is now verified
          verificationCompleted: verified,

          /// Called when the verification is failed
          verificationFailed: verificationfailed,

          /// This is called after the OTP is sent. Gives a `verificationId` and `code`
          codeSent: smsSent,

          /// After automatic code retrival `tmeout` this function is called
          codeAutoRetrievalTimeout: autoTimeout);
    }
*/
    @override
    Widget build(BuildContext context) {
      return Scaffold(

        appBar: AppBar(),

        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(
            top: 30,
            bottom: 30,
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
        resizeToAvoidBottomInset: false,
      );
    }

    Widget buildTitle() {
      return Text(
        'Enter your Phone',
        style: TextStyle(
          fontSize: 25,
        ),
      );
    }

    Widget buildForm() {
      return Container(
        width: 330,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
            children: [
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
                          //verifyPhone(_phoneNumberController);
                        },
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
                          }
                          return null;
                        },
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
                ],
              ),
             /* Text("OTP"),

              Container(
                width: 330,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Form(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _smsController,
                    autocorrect: false,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: '••••••',
                      hintStyle: TextStyle(
                        fontSize: 20,
                      ),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Text(
                'Didnt receive it? Tap to resend.',
                style: TextStyle(color: Colors.grey),
              ),*/
            ]
        ),
      );
    }

    Widget buildBottom() {
      return Column(
        children: [
          Text(
            'By signing up,you\'re agreeing to our\nTerms or Services and Privacy Policy. Thanks!',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          RoundButton(
            color: Style.AccentBlue,
            minimumWidth: 230,
            disabledColor: Style.AccentBlue.withOpacity(0.3),
            onPressed: onSignUpButtonClick,

            /*onPressed: () {
            verifyPhone('+91${_phoneNumberController.text}');

          }*/
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
            ), // Once signed in, return the UserCredential
          )

        ],
      );
    }

    signUp() {
      /*
      verifyPhone('+91' + '${_phoneNumberController.text}');
      print('+91' + '${_phoneNumberController.text}');

      AuthService().signInWithOTP(
          context, _smsController.text,this.verificationId);
     // History.pushPageUntil(context, UsernamePage());

    /*
    Navigator.of(context)
        .pushNamed('untitled/pages/welcome/sms_screen.dart', arguments: this.verificationId);
  */
    History.pushPageUntil(context, UsernamePage());
  }
*/
      History.pushPage(context,SmsScreen('+91' + '${_phoneNumberController.text}'));
    }
  }

