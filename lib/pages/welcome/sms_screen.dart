import 'package:audio_show/pages/welcome/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:clubhouse/utils/app_color.dart';
//import 'package:clubhouse/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:audio_show/pages/welcome/username.dart';
import 'package:audio_show/util/history.dart';
import 'package:audio_show/widgets/round_button.dart';


/// The screen for input verification code
/// Made up of three main components: title, form, bottom part

class SmsScreen extends StatefulWidget {
  final String verificationId;

  const SmsScreen(String s, {Key key, this.verificationId}) : super(key: key);
  @override
  _SmsScreenState createState() => _SmsScreenState();
}

class _SmsScreenState extends State<SmsScreen> {
  final _smsController = TextEditingController();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 30, bottom: 60),
        child: Column(
          children: [
            title(),
            SizedBox(height: 50),
            form(),
            Spacer(),
            bottom(),
          ],
        ),
      ),
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.only(left: 80.0, right: 80.0),
      child: Text(
        'Enter the code we just texted you',
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget form() {
    return Column(
      children: [
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
              keyboardType: TextInputType.visiblePassword,
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
        ),
      ],
    );
  }

  Widget bottom() {
    return Column(
      children: [
        SizedBox(height: 30),
        RoundButton(
          color: Colors.blueAccent,
          minimumWidth: 230,
          disabledColor: Colors.blueAccent.withOpacity(0.3),
          onPressed: () {
            //verifyPhone(s)
            AuthService().signInWithOTP(
                context, _smsController.text, widget.verificationId);
         //   History.pushPageUntil(context, UsernamePage());
          },
          child: Container(

            child: Row(
              mainAxisSize: MainAxisSize.min,

              children: [
                Text(
                  'Next',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Icon(Icons.arrow_right_alt, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }

 /* next() {
    History.pushPageUntil(context,UsernamePage());
  }

  */
}
