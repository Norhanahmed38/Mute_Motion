import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mute_motion_passenger/constants.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String validatorMessage;
  final TextInputType keyboardType;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.validatorMessage,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
        hintStyle: GoogleFonts.comfortaa(
          color: kPrimaryColor,
          fontSize: 12.sp,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMessage;
        }
        if (labelText == 'Card Number' && value.length != 16) {
          return 'Card Number must be 16 digits';
        }
        if (labelText == 'CVV' && value.length != 3) {
          return 'CVV must be 3 digits';
        }
        if (labelText == 'Expiry Date' && !RegExp(r'^(0?[1-9]|1[012])\/([0-9]{4})$').hasMatch(value)) {
          return 'Expiry Date must be in MM/YYYY format';
        }
        return null;
      },
    );
  }
}
