import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/requests/presentation/views/requests_view.dart';

class stack_model extends StatelessWidget {
  const stack_model({
    super.key,
    required this.image,
    required this.type,
    required this.widdget,
    required this.top,
    required this.hight,
    required this.color,
  });
  final String image;
  final String type;
  final Widget widdget;
  final double top;
  final double hight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: const Size(40, 70),
            backgroundColor: color,
          ),
          onPressed: () {
            navigateTo(context, widdget);
          },
          child: Column(
            children: [
              SizedBox(
                height: 7,
              ),
              Text(
                type,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          top: top,
          child: Image.asset(
            image,
            height: hight,
          ),
        )
      ],
    );
  }
}
