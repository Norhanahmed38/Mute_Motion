import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mute_motion_passenger/constants.dart';

class CustomDropDownn extends StatefulWidget {
  final List<String> items;

  CustomDropDownn({super.key, required this.items});

  @override
  State<CustomDropDownn> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDownn> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            hint: const Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            value: dropdownValue,
            elevation: 0,
            style: GoogleFonts.lato(color: kPrimaryColor),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            items: widget.items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(value == "VISA"
                        ? Icons.call_to_action_rounded
                        : Icons.attach_money_sharp),
                    Text(
                      " $value",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
