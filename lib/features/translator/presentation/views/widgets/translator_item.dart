import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mute_motion_passenger/core/styles.dart';

class TranslatorChatItem extends StatelessWidget {
  const TranslatorChatItem({Key? key, required this.text, required this.onPressed}) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 160.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.w),
        color: Colors.white,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: Styles.textStyle12,
        ),
      ),
    );
  }
}