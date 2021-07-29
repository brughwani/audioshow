import 'package:audio_show/models/user.dart';
//import 'package:untitled/util/data.dart';
import 'package:audio_show/widgets/round_image.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Userprofile profile;

  const ProfilePage({Key key, this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: Text('Voice filter'),
              onTap: () {

                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Edit username'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Voice change'),
              onTap: () {


              },
            )
          ],
        ), // Populate the Drawer in the next step.
      ),



      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Builder(
          builder: (context) =>IconButton(
            icon: Icon(Icons.settings_rounded),
            onPressed: () =>Scaffold.of(context).openEndDrawer(

            ),
          ),

        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            buildProfile(),
            SizedBox(
              height: 20,
            ),
            builderInviter(),
          ],
        ),
      ),
    );

  }

  Widget buildProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RoundImage(
          path: profile.profileImage,
          width: 50,
          height: 50,
          borderRadius: 35,
        ),
        SizedBox(
          height: 20,
        ),

        SizedBox(
          height: 5,
        ),
        Text(
          profile.username,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: profile.followers,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: ' followers'),
                ],
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              width: 50,
            ),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: profile.following,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: ' following'),
                ],
                style: TextStyle(
                  color: Colors.black,
                )         ,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "I am on Audioshow",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  Widget builderInviter() {
    return Row(
      children: [
        RoundImage(
          path: "https://robohash.org/?set=set3",
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Joined Mar 28, 2021'),
            SizedBox(height: 3,),

          ],
        ),
      ],
    );
  }
}
