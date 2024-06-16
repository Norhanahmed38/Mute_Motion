
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransportApi {
  static const transportUrl = 'https://mutemotion.onrender.com/api/v1/findNearestDriver';
  
  sendTransportRequest({
    required BuildContext context,
    required TextEditingController locationCont,
    required TextEditingController destCont,
    required TextEditingController costCont,
    required String paymentCont,
    required String servType,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? id = prefs.getString("_id");
      String? token = prefs.getString("token"); // Retrieve the token
      print('The id is $id');
      print('The token is $token');
      
      Map<String, dynamic> requestBody = {
        "startLat": locationCont.text.split(',')[0],
        "startLon": locationCont.text.split(',')[1],
        "destLat": destCont.text.split(',')[0],
        "destLon": destCont.text.split(',')[1],
        "expectedCost": costCont.text,
        "paymentMethod": paymentCont,
        "serviceType": servType, // Assuming a static value for serviceType
        "locationName": locationCont.text,
        "destinationName": destCont.text,
      };
      print('Request body: $requestBody');

      Response response = await Dio().get(
        transportUrl,
        queryParameters: requestBody, // Use queryParameters for GET request
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      print('After sending request');
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Request successful');
        print(response.data);
      }
    } catch (error) {
      if (error is DioException) {
        print(error.response?.data);
        _showErrorDialog(
          context,
          "Some data are faulty",
          destCont,
          locationCont,
          costCont,
          paymentCont,
        );
      }
    }
  }
}

void _showErrorDialog(
  BuildContext context,
  String message,
  TextEditingController destination,
  TextEditingController location,
  TextEditingController cost, String paymentCont,
) {
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
              destination.clear();
              location.clear();
              cost.clear();

              Navigator.of(context).pop();
            },
            child: Container(
              width: 120,
              height: 45,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  'Try Again',
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
