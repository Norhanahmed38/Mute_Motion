import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/core/styles.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.sentByMe, required this.message});
  final bool sentByMe;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        decoration: BoxDecoration(
          color: sentByMe ? chatColorMe : kPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: Styles.textStyle15.copyWith(
                color: sentByMe ? kPrimaryColor : Colors.white,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '1:10 AM',
              style: Styles.textStyle12.copyWith(
                color:
                    (sentByMe ? kPrimaryColor : Colors.white).withOpacity(0.6),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
