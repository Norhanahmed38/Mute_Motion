import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/driverProfile/presentation/views/DriverProfileView.dart';
import 'package:mute_motion_passenger/features/driverProfile/presentation/views/widgets/driver_profile_view_body.dart';
import 'package:mute_motion_passenger/features/requests/data/models/driver_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../trip_track/provider/map_provider.dart';

class TransportApi {
  static const transportUrl =
      'https://mutemotion.onrender.com/api/v1/findNearestDriver';

  Future<void> sendTransportRequest({
    required BuildContext context,
    required TextEditingController locationCont,
    required TextEditingController destCont,
    required TextEditingController costCont,
    required double startLat,
    required double startLon,
    required double destLat,
    required String paymentCont,
    required double destLon,
    required String servType,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      print('The token is $token');

      Map<String, dynamic> queryParameters = {
        "startLat": startLat,
        "startLon": startLon,
        "destLat": destLat,
        "destLon": destLon,
        "expectedCost": costCont.text,
        "paymentMethod": paymentCont,
        "serviceType": servType,
        "locationName": locationCont.text,
        "destinationName": destCont.text,
      };

      print('Query parameters: $queryParameters');

      Response response = await Dio().get(
        transportUrl,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Request successful');
        print(response);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("sessionId", response.data["sessionId"]);
        await prefs.setString("driver_id", response.data["driver"]["_id"]);
        String driverId = prefs.getString("driver_id")!;

        if (response.data != null) {
          final driverModel = DriverModel.fromJson(response.data);
          navigateTo(context, DriverProfileViewBody(driverModel: driverModel));
        } else {
          _showErrorDialog(
            context,
            "Invalid response from server",
            destCont,
            locationCont,
            costCont,
            paymentCont,
          );
        }
      } else {
        print('Request failed with status code: ${response.statusCode}');
        print(response.data);
        _showErrorDialog(
          context,
          "Request failed with status code: ${response.statusCode}",
          destCont,
          locationCont,
          costCont,
          paymentCont,
        );
      }
    } catch (error) {
      print('Request failed with error:');
      print(error);
      _showErrorDialog(
        context,
        "Failed to send request. Please try again.",
        destCont,
        locationCont,
        costCont,
        paymentCont,
      );
    }
  }

  void _showErrorDialog(
    BuildContext context,
    String message,
    TextEditingController destination,
    TextEditingController location,
    TextEditingController cost,
    String paymentCont,
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
}
