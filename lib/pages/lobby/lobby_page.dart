import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audio_show/pages/lobby/widgets/room_card.dart';
import 'package:audio_show/pages/lobby/widgets/schedule_card.dart';
import 'package:audio_show/models/room.dart';
//import 'package:untitled/util/data.dart';
import 'package:audio_show/widgets/round_button.dart';
import 'package:audio_show/util/style.dart';
import 'package:audio_show/pages/lobby/widgets/lobby_bottom_sheet.dart';
import 'package:audio_show/pages/room/room_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
class LobbyPage extends StatefulWidget {
  @override
  _LobbyPageState createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }



  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [

        buildGradientContainer(),
        buildStartRoomButton(),
      ],
    );
  }

  Widget buildScheduleCard() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: ScheduleCard(),
    );
  }

  Widget buildRoomCard(Room room) {
    return GestureDetector(
      onTap: () {
        enterRoom(room);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: RoomCard(
          room: room,
        ),
      ),
    );
  }

  Widget buildGradientContainer() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter, colors: [Colors.deepOrangeAccent,Colors.deepOrangeAccent],
        ),

      ),
    );
  }

  Widget buildStartRoomButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: RoundButton(
          onPressed: () {
            showBottomSheet();
          },
          color: Style.AccentBlue,
          text: '+ Start an Audioshow'),
    );
  }

  enterRoom(Room room) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (rc) {
        return RoomPage(
          room: room,
        );
      },
    );
  }

  showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            )),
        builder: (context) {
          return Wrap(
              children: [
                LobbyBottomSheet(
                    onButtonTap: () async {
                      /*await collection.add(
                      {
                        'title': '${myProfile.name}\'s Room',
                        'users': [profileData],
                        'speakerCount': 1
                      },
                    );*/
                      await Permission.microphone.request();
                      Navigator.pop(context);

                      enterRoom(
                        Room(
                          title: '{/*myProfile.username}*/"s Audioshow',
                          users: [/*myProfile*/],
                          speakerCount: 1,
                        ),
                      );

                      // ignore: unnecessary_statements
                      ClientRole.Broadcaster;
                    }
                )
              ]
          );
        }



    );
  }
}
