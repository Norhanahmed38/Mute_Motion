import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class custemcodefield extends StatelessWidget {
  custemcodefield({
    super.key,
    required this.controller,
  });
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Color(0xD9D9D9),
      width: 80.w, height: 78.h,
      decoration: BoxDecoration(
          color: Color(0xD9D9D9),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 2)
          ]),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: TextFormField(
          validator: ((value) {
            if (value!.isEmpty) {
              return "Code field can't be empty";
            }
            return null;
          }),
          maxLength: 1,
          controller: controller,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(),
        ),
      ),
    );
  }
}
