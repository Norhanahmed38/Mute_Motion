import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class custemlabel extends StatelessWidget{
  const custemlabel({super.key, required this.icon, required this.Place});
final IconData icon;
final String Place;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 377.w,
      height: 45.h,
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          prefixIcon:Icon(
            icon,
            size: 18.sp,
            color: Colors.white,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          hintText:Place,
          hintStyle: TextStyle(color: Colors.white,fontSize: 18.sp,fontFamily:'comfortaa')
        ),
      ),
    );
  }

}