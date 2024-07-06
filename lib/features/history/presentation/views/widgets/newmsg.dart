import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mute_motion_passenger/features/history/presentation/views/widgets/custommtext.dart';

class newmsg extends StatelessWidget {
  newmsg({
    super.key,
    required this.req,
    required this.driverName,
    required this.rate,
    required this.destination,
    required this.psg_loc,
    required this.paymentMethod,
    required this.Cost,
  });

  final String req;
  final String driverName;
  final String rate;
  final String destination;
  final String psg_loc;
  final String paymentMethod;
  final String Cost;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Container(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            height: 44.h,
            width: 300.w,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                SizedBox(
                  width: 70.w,
                ),
                Text(
                  req,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Comfortaa',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ]),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: Container(
            margin: EdgeInsets.only(right: 22.w, left: 15.w),
            padding: EdgeInsets.all(9),
            height: 203.h,
            width: 300.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: kPrimaryColor),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    custommtext(
                      text: 'Driver:',
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    custommtext(
                      text: driverName,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      width: 65.w,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    custommtext(
                      text: rate,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    custommtext(text: 'From:', fontWeight: FontWeight.w600),
                    SizedBox(
                      width: 10.w,
                    ),
                    custommtext(text: psg_loc, fontWeight: FontWeight.w400),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    custommtext(
                      text: 'To:',
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    custommtext(
                      text: destination,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    custommtext(
                      text: 'payment Method:',
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    custommtext(
                      text: paymentMethod,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Divider(
                  indent: 10.w,
                  endIndent: 10.w,
                  color: kPrimaryColor,
                  thickness: 1.h,
                  height: 2.h,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    custommtext(
                      text: 'Cost:',
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    custommtext(
                      text: 'EGP $Cost',
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
