import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomServiceTypeDropDown extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String> onChanged;

  CustomServiceTypeDropDown({Key? key, required this.items, required this.onChanged}) : super(key: key);

  @override
  State<CustomServiceTypeDropDown> createState() => _CustomServiceTypeDropDownState();
}

class _CustomServiceTypeDropDownState extends State<CustomServiceTypeDropDown> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            hint:  Text(
              'Service Type',
              style: TextStyle(
                fontSize: 17.sp,
              ),
            ),
            value: dropdownValue,
            elevation: 0,
            style: GoogleFonts.lato(color: kPrimaryColor),
            onChanged: (String? value) {
              setState(() {
                dropdownValue = value; // Update local state
              });
              widget.onChanged(value!); // Notify parent widget
            },
            items: widget.items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
