import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';

class newmssg extends StatelessWidget {
  newmssg({
    super.key,
    required this.req,
    required this.driverName,
    required this.rate,
    required this.destination,
    required this.psg_loc,
    required this.datee,
    required this.Cost,
    required this.no_bags,
    required this.no_pass,
  });

  static int num = 0;
  final String req;
  final String driverName;
  final String rate;
  final String destination;
  final String psg_loc;
  final String datee;
  final String Cost;
  final String no_bags;
  final String no_pass;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.00),
          child: Container(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 44,
            width: 320,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.white,
                    ),
                    Text(
                      '${++num}',
                      style: TextStyle(
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 50,
                ),
                Text(
                  req,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Comfortaa',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Container(
            margin: EdgeInsets.only(right: 22, left: 15),
            padding: EdgeInsets.all(9),
            height: 290,
            width: 320,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kPrimaryColor),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Driver:',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Comfortaa',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      driverName,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Comfortaa',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      rate,
                      style: TextStyle(
                        fontFamily: ' Comfortaa',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      'From:',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Comfortaa',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      psg_loc,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Comfortaa',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      'To:',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Comfortaa',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      destination,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Comfortaa',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      'To:',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Comfortaa',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Salah Eldeen Street-Elzamalek',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Comfortaa',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      'No of passengers:',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Comfortaa',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      no_pass,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Comfortaa',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'No of Bags:',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Comfortaa',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      no_bags,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Comfortaa',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      'Date:',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Comfortaa',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      datee,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Comfortaa',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  indent: 10,
                  endIndent: 10,
                  color: kPrimaryColor,
                  thickness: 1,
                  height: 2,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Cost:',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: 'Comfortaa',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'EGP $Cost',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontFamily: 'Comfortaa',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
