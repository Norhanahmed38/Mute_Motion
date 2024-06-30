import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void _showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        content: Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.sp, fontFamily: 'Comfortaa', color: Colors.white),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: 'Comfortaa',
                  color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}
