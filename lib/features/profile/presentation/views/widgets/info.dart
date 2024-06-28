import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';

class Info extends StatelessWidget {
  final String title;
  final String subTitle;

  const Info({
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 17, color: kPrimaryColor),
      ),
      subtitle: Text(
        subTitle,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}