import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/core/utils/widgets/custom_map.dart';
import 'package:mute_motion_passenger/features/Rating/presentation/views/rating_view.dart';
import 'package:mute_motion_passenger/features/chat/presentation/views/chat_screen_view.dart';
import 'package:mute_motion_passenger/features/chat/presentation/views/widgets/chat_screen_view_body.dart';
import 'package:mute_motion_passenger/features/driverProfile/presentation/views/widgets/customtext.dart';
import 'package:mute_motion_passenger/features/map/map.dart';
import 'package:mute_motion_passenger/features/requests/data/models/driver_model.dart';
import 'package:mute_motion_passenger/features/driverProfile/data/request_api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mute_motion_passenger/features/trip_track/view/map_screen.dart';

class DriverProfileViewBody extends StatefulWidget {
  final DriverModel? driverModel;

  const DriverProfileViewBody({super.key, this.driverModel});

  @override
  State<DriverProfileViewBody> createState() => _DriverProfileViewBodyState();
}

class _DriverProfileViewBodyState extends State<DriverProfileViewBody> {
  @override
  Widget build(BuildContext context) {
    String displayedRating =
        double.parse(widget.driverModel?.driver?.rating ?? '0')
            .toStringAsFixed(1);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: kPrimaryColor,
            appBar: AppBar(
              title: Text(
                'Driver Profile',
                style: GoogleFonts.comfortaa(
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
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
                padding: EdgeInsets.only(
                  top: 20.h,
                  left: 7.w,
                  right: 7.w,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    )),
                child: Padding(
                  padding: EdgeInsets.only(
                      right: 5.w, top: 20.h, bottom: 20.h, left: 5.w),
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
                        "After ${widget.driverModel?.estimatedTimeToArrive}mins (${widget.driverModel?.distanceToDriver})m ",
                        style: GoogleFonts.comfortaa(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff760F07),
                        ),
                      ),
                      Text(
                        "The cost of the trip will be ${widget.driverModel?.cost}EGP",
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
                        " ${widget.driverModel?.driver?.fullname}",
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
                          GestureDetector(
                            onTap: () {
                              navigateTo(context, MapScreenn());
                            },
                            child: FaIcon(
                              FontAwesomeIcons.solidStar,
                              color: Color(0xffF7B731),
                              size: 15.sp,
                            ),
                          ),
                          Text(
                            " $displayedRating (${widget.driverModel?.driver?.numberOfReviews}Reviewers)",
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
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        width: double.infinity,
                        height: 110.h,
                        decoration: BoxDecoration(
                            color: const Color(0xff003248),
                            borderRadius: BorderRadius.circular(15.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                customtext(
                                  widget: widget,
                                  text:
                                      "car number: ${widget.driverModel?.driver?.carnum}",
                                ),
                                customtext(
                                  widget: widget,
                                  text:
                                      "car color: ${widget.driverModel?.driver?.color}",
                                ),
                                customtext(
                                  widget: widget,
                                  text:
                                      "car model: ${widget.driverModel?.driver?.model}",
                                ),
                                customtext(
                                  widget: widget,
                                  text:
                                      "  cardescription: ${widget.driverModel?.driver?.cardescription} ",
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
                            const FaIcon(FontAwesomeIcons.solidEnvelope),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              " ${widget.driverModel?.driver?.email}",
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
                            const FaIcon(FontAwesomeIcons.phone),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              " ${widget.driverModel?.driver?.phone}",
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
                                  ApiService.sendRequest(context);

                                  Navigator.push(
                                   context,
                                  MaterialPageRoute(
                                    builder: (context) => RouteScreen(),
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
                            ]),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
