import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/core/styles.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.sentByMe, required this.message, required this.time,});
  final bool sentByMe;
  final String message;
  final String time;
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
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          //spacing: 8,
          //textBaseline: TextBaseline.alphabetic,
          //mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              softWrap: true,
              message,
              style: Styles.textStyle15.copyWith(
                color: sentByMe ? kPrimaryColor : Colors.white,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              children: [
                Text(
                  time,
                  style: Styles.textStyle12.copyWith(
                    color:
                        (sentByMe ? kPrimaryColor : Colors.white).withOpacity(0.6),
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
