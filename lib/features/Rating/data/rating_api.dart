import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/history/presentation/views/history_screen_view.dart';
import 'package:mute_motion_passenger/features/mainMenu/presentation/views/mainMenu_screen_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingApi {
  static const String baseUrl =
      "https://mutemotion.onrender.com/api/v1/rateDriver";

  Future<void> userRate({
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
        showRatingDialog(
          context: context,
          title: 'Error',
          content: 'Driver ID is not available. Please try again later.',
        );
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
        showRatingDialog(
          context: context,
          title: 'Success',
          content: 'Rating submitted successfully.',
        );
      } else {
        // Handle non-200 status code
        print('Request failed with status: ${response.statusCode}');
        showRatingDialog(
          context: context,
          title: 'Error',
          content:
              'Failed to submit rating. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      // Handle Dio exceptions
      print('Request failed with error: $e');
      showRatingDialog(
        context: context,
        title: 'Error',
        content: ' An error occurred ',
      );
    }
  }

  // Define the dialog function at the end of userRate
  void showRatingDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            title,
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            content,
            style: TextStyle(color: kPrimaryColor, fontSize: 15.sp),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                navigateTo(context, MainMenuScreenView());
              },
              style: TextButton.styleFrom(
                foregroundColor: kPrimaryColor,
              ),
              child: Text(
                'OK',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
