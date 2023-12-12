import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mute_motion_passenger/constants.dart';

class CustomDropDownn extends StatefulWidget {
  CustomDropDownn({super.key});

  @override
  State<CustomDropDownn> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDownn> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: DropdownButton(
            isExpanded: true,
            hint: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text('Payment Method',
                  style: (TextStyle(
                    fontSize: 18,
                  ))),
            ),
            value: dropdownValue,
            /* icon: const Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(Icons.arrow_downward),
                              ), */
            elevation: 0,
            style: GoogleFonts.lato(color: kPrimaryColor),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            items: [
              DropdownMenuItem(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.call_to_action_rounded),
                      Text(" VISA",
                          style: (TextStyle(
                            fontSize: 18,
                          ))),
                    ],
                  ),
                ),
                value: "VISA",
              ),
              DropdownMenuItem(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.attach_money_sharp),
                      Text(
                        "CASH",
                        style: (TextStyle(
                          fontSize: 18,
                        )),
                      ),
                    ],
                  ),
                ),
                value: " CASH",
              ),
            ]),
      ),
    );
  }
}
