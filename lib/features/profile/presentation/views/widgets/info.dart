import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
        style: TextStyle(fontSize: 17.sp, color: kPrimaryColor),
      ),
      subtitle: Text(
        subTitle,
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}