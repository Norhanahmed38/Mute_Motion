import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mute_motion_passenger/constants.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static Future<void> sendRequest(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String? sessionId = prefs.getString('sessionId');
      print('Session ID: $sessionId');

      if (token != null && sessionId != null) {
        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };
        Map<String, dynamic> body = {
          'sessionId': sessionId,
        };
        print('Sending request');
        http.Response response = await http.post(
          Uri.parse('https://mutemotion.onrender.com/api/v1/sendrequest'),
          headers: headers,
          body: json.encode(body),
        );
        print('Response received: ${response.statusCode}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Request sent successfully');
          _showErrorDialog(context, 'Request sent successfully');
        } else {
          print('Failed to send request');
          print('Response status code: ${response.statusCode}');
          _showErrorDialog(context, 'Failed to send request');
        }
      } else {
        print('Token or Session ID is missing');
        _showErrorDialog(context, 'Token or Session ID is missing');
      }
    } catch (e) {
      print('Error occurred: $e');
      _showErrorDialog(context, 'An error occurred. Please try again later.');
    }
  }
}

void _showErrorDialog(
  BuildContext context,
  String message,
) {
  print('Showing dialog: $message'); 
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, fontFamily: 'Comfortaa', color: kPrimaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Container(
              width: 120,
              height: 45,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'OK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Comfortaa',
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
