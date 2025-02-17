import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kPrimaryColor = Color(0xff003248);
const baseUrl = 'https://mutemotion.onrender.com/';
const chatColorMe = Color(0xffffd700);

Widget myDivider() => Padding(
      padding: EdgeInsetsDirectional.only(
        start: 20.w,
        end: 20.w,
      ),
      child: Container(
        width: double.infinity,
        height: 1.h,
        color: kPrimaryColor,
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
    void navigateto(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget defaultFormField({
  required TextEditingController? controller,
  required TextInputType? type,
  int? min,
  int? max,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isClickable = true,
  Function? validate,
  required String? label,
  // IconData? prefix,
  IconData? suffix,
  bool isPassword = false,
  Function? iconButton,
}) =>
    TextFormField(
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      validator: (data) {
        if (data!.isEmpty) {
          return 'Please Enter Your Data';
        }
      },
      enabled: isClickable,
      controller: controller,
      keyboardType: type,
      minLines: min,
      maxLines: max,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          fontFamily: 'comfortaa',
          fontSize: 15.sp,
          color: kPrimaryColor,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: kPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(15.r),
        ),
        labelText: label,
        // prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix, color: kPrimaryColor, size: 20.sp),
                onPressed: () {
                  iconButton!();
                },
              )
            : null,
      ),
    );

String? userEmail;
String? driverId;

setUserEmail(String? mail) => userEmail = mail;

String? getUserEmail() {
  return userEmail;
}
