import 'package:audio_show/models/user.dart';
import 'package:audio_show/pages/home/profile_page.dart';
import 'package:audio_show/util/history.dart';
import 'package:audio_show/util/style.dart';
import 'package:audio_show/widgets/round_image.dart';
import 'package:flutter/material.dart';

class RoomProfile extends StatelessWidget {
  final Userprofile user;
  final double size;
  final bool isMute;
  final bool isModerator;

  const RoomProfile(
      {Key key,
        this.user,
        this.size,
        this.isMute = false,
        this.isModerator = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () {
                History.pushPage(
                  context,
                  ProfilePage(
                    profile: user,
                  ),
                );
              },
              child: RoundImage(
                path: user.profileImage,
                width: size,
                height: size,
              ),
            ),
            buildNewBadge(user.isNewUser),
            buildMuteBadge(isMute),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildModeratorBadge(isModerator),
            Text(
              user.username.split(' ')[0],
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildModeratorBadge(bool isModerator) {
    return isModerator
        ? Container(
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: Style.AccentGreen,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Icon(
        Icons.star,
        color: Colors.white,
        size: 12,
      ),
    )
        : Container();
  }

  Widget buildMuteBadge(bool isMute) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: isMute
          ? Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: Offset(0, 1),
            )
          ],
        ),
        child: Icon(Icons.mic_off),
      )
          : Container(),
    );
  }

  Widget buildNewBadge(bool isNewUser) {
    return Positioned(
      left: 0,
      bottom: 0,
      child: isNewUser
          ? Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: Offset(0, 1),
            )
          ],
        ),

      )
          : Container(),
    );
  }
}
