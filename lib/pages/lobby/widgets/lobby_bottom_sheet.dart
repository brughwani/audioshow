//import 'package:untitled/util/data.dart';
import 'package:audio_show/widgets/round_button.dart';
import 'package:audio_show/util/style.dart';
import 'package:audio_show/widgets/round_image.dart';
import 'package:flutter/material.dart';

class LobbyBottomSheet extends StatefulWidget {
  final Function onButtonTap;

  const LobbyBottomSheet({Key key, this.onButtonTap}) : super(key: key);

  @override
  _LobbyBottomSheetState createState() => _LobbyBottomSheetState();
}

class _LobbyBottomSheetState extends State<LobbyBottomSheet> {
  var selectedButtonIndex = 0;
  List lobbyBottomSheets = [
    {
      'image': 'assets/images/open.png',
      'text': 'Open',
      'selectedMessage': 'Start a room open to everyone',
    },
    {
      'image': 'assets/images/social.png',
      'text': 'Social',
      'selectedMessage': 'Start a room with people I follow',
    },
    {
      'image': 'assets/images/closed.png',
      'text': 'Closed',
      'selectedMessage': 'Start a room for people I choose',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        right: 20,
        left: 20,
        bottom: 20,
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            alignment: Alignment.centerRight,
            child: Text(
              '+ Add Event name',
              style: TextStyle(
                color: Style.AccentBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var i = 0, len = 3; i < len; i++)
                InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    setState(() {
                      selectedButtonIndex = i;
                    });
                  },
                  child: Ink(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                        color: i == selectedButtonIndex
                            ? Style.SelectedItemGrey
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: i == selectedButtonIndex
                              ? Style.SelectedItemBorderGrey
                              : Colors.transparent,
                        )),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: RoundImage(
                            width: 80,
                            height: 80,
                            borderRadius: 20,
                            path: lobbyBottomSheets[i]['image'],
                          ),
                        ),
                        Text(
                          lobbyBottomSheets[i]['text'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          Divider(
            thickness: 1,
            height: 60,
            indent: 20,
            endIndent: 20,
          ),
          Text(
            lobbyBottomSheets[selectedButtonIndex]['selectedMessage'],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RoundButton(
            color: Style.AccentBlue,
            onPressed: widget.onButtonTap,
            text: 'Start the session',
          )
        ],
      ),
    );
  }
}
