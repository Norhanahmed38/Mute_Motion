import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RatingApi {
  static const String baseUrl =
      "https://mutemotion.onrender.com/api/v1/rateDriver";

  userRate({
    required BuildContext context,
    required String rating,
    required VoidCallback onSuccess,
  }) async {
    try {
      // Retrieve the driverId from SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? driverId = prefs.getString("driver_id");
      print(driverId);
      if (driverId == null) {
        print("Driver ID is not available.");
        return;
      }
      Map<String, dynamic> requestBody = {
        "driverId": driverId,
        "rating": rating,
      };
      print(requestBody);
      Response response = await Dio().post("$baseUrl", data: requestBody);
      // Check if response is successful
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Request successful');
        print('Response: ${response.data}');
        // Invoke the callback to notify the UI about the successful submission
        onSuccess();
        // Show success dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white, // Set background color to white
              title: Text(
                'Success',
                style: TextStyle(
                    color: Color(0xff100B20), fontWeight: FontWeight.bold),
              ),
              content: Text(
                'Rating submitted successfully.',
                style: TextStyle(color: Color(0xff100B20), fontSize: 15),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Color(0xff100B20), // Set button text color
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(
                        color: Color(0xff100B20),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        // Handle non-200 status code
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle Dio exceptions
      print('Request failed with error: $e');
    }
  }
}