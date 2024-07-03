import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/mainMenu/presentation/views/mainMenu_screen_view.dart';

class PaymentCompletedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: kPrimaryColor,
              size: 105.sp,
            ),
            SizedBox(height: 20.h),
            Text(
              'Payment completed ',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 24.sp,
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                navigateTo(context, MainMenuScreenView());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.h),
              ),
              child: Text(
                'CONTINUE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
