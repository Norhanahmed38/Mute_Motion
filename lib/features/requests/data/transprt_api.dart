import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransportApi {
  static const transportUrl = 'https://mutemotion.onrender.com/api/transports';
  sendTransportRequest({
    required BuildContext context,
    required String? dateAndTime,
    required TextEditingController locationCont,
    required TextEditingController destCont,
    required TextEditingController costCont,
    required TextEditingController paymentCont,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? id = prefs.getString("_id");
      print('The id is $id');
      Map<String, dynamic> requestBody = {
        "location": locationCont.text,
        "destination": destCont.text,
        "dateAndtime": dateAndTime,
        "expectedCost": costCont.text,
        "paymentMethod": 'cash',
        "driver": null,
        "passengerId": id,
      };
      print('aaaaaaaaaa3333333');
      Response response = await Dio().post("$transportUrl", data: requestBody);
      print('after posting request');
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
  TextEditingController cost,
  TextEditingController payment,
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
          // ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              payment.clear();
              destination.clear();
              location.clear();
              cost.clear();

              Navigator.of(context).pop();
              // navigateTo(context, RequestsBody());
              // Close the dialog
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
