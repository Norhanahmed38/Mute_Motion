import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mute_motion_passenger/features/driverProfile/presentation/views/widgets/driver_profile_view_body.dart';

class customtext extends StatelessWidget {
  customtext({
    super.key,
    required this.widget,
    required this.text,
  });

  final DriverProfileViewBody widget;
  String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.comfortaa(fontSize: 10.sp, color: Colors.white),
    );
  }
}