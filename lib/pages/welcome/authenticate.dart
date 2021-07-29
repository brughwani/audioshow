import 'package:audio_show/pages/welcome/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:audio_show/pages/welcome/phone.dart';
import 'package:audio_show/pages/welcome/authenticate.dart';
//import 'package:untitled/pages/welcome/welcome_page.dart';

class AuthService {
  /// returns the initial screen depending on the authentication results
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return WelcomePage();
        } else {
          return PhoneNumberPage();
        }
      },
    );
  }

  /// This method is used to logout the `FirebaseUser`
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  /// This method is used to login the user
  ///  `AuthCredential`(`_phoneAuthCredential`) is needed for the signIn method
  /// After the signIn method from `AuthResult` we can get `FirebaserUser`(`_firebaseUser`)


  signIn(BuildContext context, AuthCredential authCreds) async {

    await FirebaseAuth.instance.signInWithCredential(authCreds);

    if ((await FirebaseAuth.instance.signInWithCredential(authCreds)).user != null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("untitled/pages/welcome/welcome_page.dart", (route) => false);
    } else {
      print("Error");
    }
  }

  /// get the `smsCode` from the user
  /// when used different phoneNumber other than the current (running) device
  /// we need to use OTP to get `phoneAuthCredential` which is inturn used to signIn/login
  signInWithOTP(BuildContext context, smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.credential(
        verificationId: verId, smsCode: smsCode);
    signIn(context, authCreds);
  }
}
