import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/profile/presentation/views/profile_screen_view.dart';

class hadwidget extends StatelessWidget {
  const hadwidget({
    super.key,
    required this.darkGreen,
  });

  final Color darkGreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGreen,
      height: 150,
      width: 380,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: (Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/woman.png'),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 55, left: 8),
                    child: Text(
                      'Norhan Ahmed',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      'nour.ahmed12@gmail.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Padding(
                padding: EdgeInsets.only(top: 35),
                child: IconButton(
                  onPressed: () {
                    navigateTo(context, ProfileScreenView());
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
