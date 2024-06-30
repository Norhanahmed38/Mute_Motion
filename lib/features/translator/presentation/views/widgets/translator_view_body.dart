import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/translator/presentation/views/Text_to_sign.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../navdrawer/presentation/views/nav_drawer_view.dart';

class TranslatorViewBody extends StatelessWidget {
  const TranslatorViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawerView(),
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Interpreter Mode',
          style: GoogleFonts.comfortaa(fontSize: 20.sp, color: Colors.white),
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
        child: Padding(
          padding:
              EdgeInsets.only(right: 20.w, top: 30.h, bottom: 20.h, left: 10.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Image.asset('assets/images/translator.png'),
                Text(
                  'Sign Language Support',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.comfortaa(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Just a heads up! Our driver communicates in sign language. We’re translating their messages for you ',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.comfortaa(
                    fontSize: 14.sp,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Container(
                  width: double.infinity,
                  height: 60.h,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(15.r)),
                  child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TextToSign()));
                      },
                      child: Text(
                        "Start Chatting",
                        style: GoogleFonts.comfortaa(
                            fontSize: 20.sp, color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
