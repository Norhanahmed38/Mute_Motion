import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/navdrawer/presentation/views/nav_drawer_view.dart';

class AboutUsScreenBody extends StatelessWidget {
  const AboutUsScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(360, 690),
    );
    return Scaffold(
      backgroundColor: kPrimaryColor,
      drawer: const NavDrawerView(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'About Us',
          style: TextStyle(
              fontSize: 22.sp, fontFamily: 'Lato', color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft:
                Radius.circular(20.w), // Using ScreenUtil for rounded corners
            topRight: Radius.circular(20.w),
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: 20.h, horizontal: 10.w), // Using ScreenUtil for padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Let’s introduce ourselves!',
                style: TextStyle(
                    fontSize: 22.sp, fontFamily: 'Lato', color: kPrimaryColor),
              ),
              SizedBox(height: 10.h),
              Image.asset(
                'assets/images/US.jpg',
                height: 200.h, // Using ScreenUtil for image height
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20.h),
              Container(
                margin: EdgeInsets.only(right: 22.w, left: 10.w),
                padding: EdgeInsets.all(9.w),
                height: 370.h, // Using ScreenUtil for container height
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.w),
                  border: Border.all(color: kPrimaryColor),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    'The "MuteMotion" project aims to create an innovative smart taxi service catering specifically to deaf and mute drivers. It involves the development of advanced driver assistance systems (ADAS) using artificial intelligence (AI) and mobile application technologies. By enhancing safety features, communication tools, and convenience, MuteMotion seeks to empower the deaf/mute community with job opportunities and effective interaction platforms.',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'Comfortaa',
                        color: kPrimaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
