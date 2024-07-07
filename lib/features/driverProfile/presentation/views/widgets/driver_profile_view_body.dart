import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/Rating/presentation/views/rating_view.dart';
import 'package:mute_motion_passenger/features/chat/presentation/views/chat_screen_view.dart';
import 'package:mute_motion_passenger/features/chat/presentation/views/widgets/chat_screen_view_body.dart';
import 'package:mute_motion_passenger/features/driverProfile/presentation/views/widgets/customtext.dart';
import 'package:mute_motion_passenger/features/requests/data/models/driver_model.dart';
import 'package:mute_motion_passenger/features/driverProfile/data/request_api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../constants.dart';
import '../../../../Rating/presentation/views/rating_view.dart';
import '../../../../requests/data/models/driver_model.dart';
import '../../../../trip_track/view/map_screen.dart';

// Assuming these are your imports for other widgets and constants
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Assuming these are your imports for other widgets and constants


class DriverProfileViewBody extends StatefulWidget {
  final DriverModel? driverModel; // Make driverModel nullable
  final String location;
  final String destination;
  final String cost;

  const DriverProfileViewBody({
    this.driverModel, // Nullable driverModel
    required this.location,
    required this.destination,
    required this.cost,
  });

  @override
  State<DriverProfileViewBody> createState() => _DriverProfileViewBodyState();
}

class _DriverProfileViewBodyState extends State<DriverProfileViewBody> {
  @override
  Widget build(BuildContext context) {
    String displayedRating =
    double.parse(widget.driverModel?.driver?.rating ?? '0').toStringAsFixed(1);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
            title: Text(
              'Driver Profile',
              style: GoogleFonts.comfortaa(
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Driver will be in your destination ",
                    style: GoogleFonts.comfortaa(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                  Text(
                    "After ${widget.driverModel?.estimatedTimeToArrive ?? 0} mins (${widget.driverModel?.distanceToDriver ?? 0} m) ",
                    style: GoogleFonts.comfortaa(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff760F07),
                    ),
                  ),
                  Text(
                    "The cost of the trip will be ${widget.cost} EGP",
                    style: GoogleFonts.comfortaa(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CircleAvatar(
                    radius: 60.r,
                    backgroundImage: AssetImage('assets/images/driver.png'),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    " ${widget.driverModel?.driver?.fullname ?? 'Unknown'}",
                    style: GoogleFonts.comfortaa(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.solidStar,
                        color: Color(0xffF7B731),
                        size: 15.sp,
                      ),
                      Text(
                        " $displayedRating (${widget.driverModel?.driver?.numberOfReviews ?? 0} Reviewers)",
                        style: GoogleFonts.comfortaa(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    width: double.infinity,
                    height: 110.h,
                    decoration: BoxDecoration(
                      color: const Color(0xff003248),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "Car number: ${widget.driverModel?.driver?.carnum ?? 'Unknown'}",
                            ),
                            CustomText(
                              text: "Car color: ${widget.driverModel?.driver?.color ?? 'Unknown'}",
                            ),
                            CustomText(
                              text: "Car model: ${widget.driverModel?.driver?.model ?? 'Unknown'}",
                            ),
                            CustomText(
                              text: "Car description: ${widget.driverModel?.driver?.cardescription ?? 'Unknown'}",
                            ),
                          ],
                        ),
                        Container(
                          child: Image.asset('assets/images/car 1.png'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    height: 58.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.solidEnvelope),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          " ${widget.driverModel?.driver?.email ?? 'Unknown'}",
                          style: GoogleFonts.comfortaa(
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    height: 58.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.phone),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          " ${widget.driverModel?.driver?.phone ?? 'Unknown'}",
                          style: GoogleFonts.comfortaa(
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h, left: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: Text(
                            "Cancel",
                            style: TextStyle(fontSize: 20.sp, color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RatingViewScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            backgroundColor: kPrimaryColor,
                            minimumSize: Size(60.w, 60.h),
                          ),
                        ),

                      SizedBox(
                        height: 40.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h, left: 5.w),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                child: Text("Cancel",
                                    style: TextStyle(
                                        fontSize: 20.sp, color: Colors.white)),
                                onPressed: () {
                                  navigateTo(context, ChatScreenView());
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  backgroundColor: kPrimaryColor,
                                  minimumSize: Size(60.w, 60.h),
                                ),
                              ),
                              SizedBox(
                                width: 30.w,
                              ),
                              ElevatedButton(
                                child: Text("confirm request",
                                    style: TextStyle(
                                        fontSize: 20.sp, color: Colors.white)),
                                onPressed: () {
                                  print('Button pressed');
                                  ApiService.sendRequest(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  backgroundColor: kPrimaryColor,
                                  minimumSize: Size(60.w, 60.h),
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            backgroundColor: kPrimaryColor,
                            minimumSize: Size(60.w, 60.h),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;

  const CustomText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.comfortaa(
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
