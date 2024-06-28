import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/core/styles.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.sentByMe,
    required this.message,
    required this.time,
  });
  final bool sentByMe;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 5.h,
          horizontal: 10.w,
        ),
        margin: EdgeInsets.symmetric(
          vertical: 3.h,
          horizontal: 10.w,
        ),
        decoration: BoxDecoration(
          color: sentByMe ? chatColorMe : kPrimaryColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            Text(
              message,
              softWrap: true,
              style: Styles.textStyle15.copyWith(
                color: sentByMe ? kPrimaryColor : Colors.white,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
          ],
        ),
      ),
    );
  }
}
