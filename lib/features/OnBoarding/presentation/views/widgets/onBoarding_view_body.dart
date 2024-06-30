import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/login_screen_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../constants.dart';

class OnBoardingViewBody extends StatefulWidget {
  @override
  State<OnBoardingViewBody> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoardingViewBody> {
  final controller = PageController();
  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          bottom: 80.h,
        ),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              if (index == 2) {
                isLastPage = true;
              }
            });
          },
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 41.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60.h,
                    ),
                    Image(
                      width: 348.w,
                      height: 325.h,
                      image: AssetImage(
                        "assets/images/SPLASHMOBILE.jpg",
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Center(
                      child: Text(
                        "Your Driver is Deaf",
                        style: GoogleFonts.comfortaa(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff003248),
                          fontSize: 22.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Center(
                      child: Text(
                        "Let's Help you Communicate Safely and Effectively",
                        style: GoogleFonts.comfortaa(
                          color: kPrimaryColor,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 41.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60.h,
                    ),
                    Image(
                      width: 348.w,
                      height: 325.h,
                      image: AssetImage(
                        "assets/images/easyPayment2.png",
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Center(
                      child: Text(
                        "Easier Payment",
                        style: GoogleFonts.comfortaa(
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                          fontSize: 22.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Center(
                      child: Text(
                        "You don't have to use cash\n Simply use your visa card or any other method",
                        style: GoogleFonts.comfortaa(
                          color: kPrimaryColor,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 41.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60.h,
                    ),
                    Image(
                      width: 348.w,
                      height: 325.h,
                      image: AssetImage(
                        "assets/images/carDrive3.png",
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Center(
                      child: Text(
                        "Enjoy The Ride",
                        style: GoogleFonts.comfortaa(
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                          fontSize: 22.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Center(
                      child: Text(
                        "Register now and enjoy your ride with us",
                        style: GoogleFonts.comfortaa(
                          color: kPrimaryColor,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? BottomSheet(
              onClosing: (() => navigateTo(context, LoginScreenView())),
              builder: (context) => Padding(
                padding: EdgeInsets.all(8.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 58.h,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(15.r)),
                      child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreenView()));
                          },
                          child: Text(
                            "Get Started",
                            style: GoogleFonts.comfortaa(
                                fontSize: 20.sp, color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              height: 80.h,
              color: Colors.white,
              child: Column(
                children: [
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        spacing: 16.w,
                        dotColor: const Color(0xff003248).withOpacity(0.6),
                        activeDotColor: kPrimaryColor,
                      ),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => controller.jumpToPage(2),
                          child: Text(
                            "Skip",
                            style: GoogleFonts.comfortaa(
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          ),
                          child: Text(
                            "Continue",
                            style: GoogleFonts.comfortaa(
                              fontWeight: FontWeight.w600,
                              color: Color(0xffe7ae00),
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
    );
  }
}