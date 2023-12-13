import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';

void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Container(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontFamily: 'Comfortaa', color: Colors.white),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'OK',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontFamily: 'Comfortaa', color: Colors.white),
              ),
            ),
          ],
        );
},
);
}