import 'package:audio_show/pages/welcome/phone.dart';
//import 'package:untitled/pages/welcome/signup_screen.dart';
import 'package:audio_show/pages/welcome/username.dart';
import 'package:audio_show/util/history.dart';
import 'package:audio_show/widgets/round_button.dart';
import "package:audio_show/util/style.dart";
//import 'package:club_house/pages/welcome/phone_number_page.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:audio_show/models/user.dart';
import 'package:audio_show/pages/welcome/otp.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.only(
          left: 50,
          right: 50,
          bottom: 60,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: 40,
            ),

            buildBottom(context),
          ],
        ),
      ),
    );
  }




  Widget buildBottom(BuildContext context) {
    final newUser= new Userprofile();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
            "assets/images/logo.png"
        ),
        RoundButton(
          color: Style.AccentBlue,
          onPressed: () {
            History.pushPage(context, LoginPage());

          },
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sign in',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                    Icons.arrow_right_alt,
                    color: Colors.white
                ),
              ],
            ),
          ),
        ),
        RoundButton(
          color: Style.AccentBlue,
          onPressed: () {
            //  History.pushPage(context, SignupPage());
          },
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sign up',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                    Icons.arrow_right_alt,
                    color: Colors.white
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

/*
            Text(
              'Sign in',
              style: TextStyle(
                color: Style.AccentBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.arrow_right_alt,
              color: Style.AccentBlue,
            ),*/
          ],
        ),
      ],
    );
  }
}
