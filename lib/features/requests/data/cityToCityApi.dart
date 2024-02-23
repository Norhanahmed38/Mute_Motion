import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CityToCityApi {
  static const CTCtUrl =
      'https://mutemotion.onrender.com/api/city-to-city-rides';
  sendCTCRequest({
    required BuildContext context,
    required TextEditingController locationCont,
    required TextEditingController destCont,
    required TextEditingController dateCont,
    required TextEditingController timeCont,
    required TextEditingController costCont,
    required TextEditingController paymentCont,
    required TextEditingController bagsCont,
    required TextEditingController passCont,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? id = prefs.getString("_id");
      print('The id is $id');
      Map<String, dynamic> requestBody = {
        "location": locationCont.text,
        "destination": destCont.text,
        "date": dateCont.text,
        "time": timeCont.text,
        "expectedCost": costCont.text,
        "noOfPassenger": passCont.text,
        "noOfBags": bagsCont.text,
        "paymentMehod": 'cash',
        "driver": null,
        "passengerId": id,
      };
      print('aaaaaaaaaa3333333');
      Response response = await Dio().post("$CTCtUrl", data: requestBody);
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
          dateCont,
          timeCont,
          costCont,
          paymentCont,
          bagsCont,
          passCont,
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
  TextEditingController date,
  TextEditingController payment,
  TextEditingController time,
  TextEditingController bags,
  TextEditingController pass,
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
              date.clear();
              payment.clear();
              destination.clear();
              location.clear();
              cost.clear();
              time.clear();
              bags.clear();
              pass.clear();
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
