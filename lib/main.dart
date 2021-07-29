import 'package:firebase_core/firebase_core.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:audio_show/pages/home/home_page.dart';
import 'package:audio_show/pages/welcome/welcome.dart';
import 'package:audio_show/util/style.dart';
import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            // ignore: missing_return
            Future<Widget> build(BuildContext context) async {
              await showDialog(
                context: context,
                builder: (context) =>
                new AlertDialog(
                  title: new Text('ERROR'),
                  content: Text(
                      'Something went wrong'),
                  actions: <Widget>[
                    new FlatButton(
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

          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            // ignore: missing_return, missing_return
            return MaterialApp(debugShowCheckedModeBanner:false,
                title: 'AudioShow',
                theme: ThemeData(
                  scaffoldBackgroundColor:Color(0xffEA7D23),
                  appBarTheme: AppBarTheme(
                    color: Color(0xffEA7D23),
                    elevation: 0.0,
                    iconTheme: IconThemeData(
                      color: Colors.black,
                    ),
                  ),
                ),

                home: WelcomePage());
          }
          return (CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.blueAccent)));
        }


    );

  }
}

// ignore:

