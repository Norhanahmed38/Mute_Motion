import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';

class Newmsg extends StatelessWidget {
  const Newmsg({
    super.key,
    required this.text1,
    required this.text2,
    required this.text3,
  });
  final String text1;
  final String text2;
  final String text3;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style:
              TextStyle(fontSize: 20, fontFamily: 'Lato', color: kPrimaryColor),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          text2,
          style: TextStyle(
              fontSize: 16, fontFamily: 'Comfortaa', color: kPrimaryColor),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          text3,
          style: TextStyle(
              fontSize: 12, fontFamily: 'Comfortaa', color: kPrimaryColor),
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Colors.grey,
          thickness: 1,
          height: 30,
        ),
      ],
    );
  }
}
