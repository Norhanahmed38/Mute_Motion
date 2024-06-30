import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mute_motion_passenger/constants.dart';

class custommtext extends StatelessWidget {
  const custommtext({
    Key? key,
    required this.text,
    required this.fontWeight,
  }) : super(key: key);
  final String text;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: kPrimaryColor,
        fontFamily: 'Comfortaa',
        fontSize: 14.sp,
        fontWeight: fontWeight,
      ),
    );
  }
}
