import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBorder extends StatelessWidget {
  const CustomBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: Text(
          'Screen Name',
          style: TextStyle(
              fontSize: 25.sp, fontFamily: 'Lato', color: Colors.white),
        ),
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 20.h,
          left: 15.w,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            )),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
