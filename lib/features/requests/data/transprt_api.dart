import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransportApi {
  static const transportUrl =
      'https://mutemotion.onrender.com/api/v1/findNearestDriver';

  sendTransportRequest({
    required BuildContext context,
    required TextEditingController locationCont,
    required TextEditingController destCont,
    required TextEditingController costCont,
    required String startLat,
    required String startLon,
    required String destLat,
    required String destLon,
    required String paymentCont,
    required String servType,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token"); // Retrieve the token
      print('The token is $token');
      Map<String, dynamic> requestBody = {
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
        print('Request failed');
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
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:mute_motion_passenger/constants.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class TransportApi {
//   static const transportUrl =
//       'https://mutemotion.onrender.com/api/v1/findNearestDriver';

//   Future<void> sendTransportRequest({
//     required BuildContext context,
//     required TextEditingController locationCont,
//     required TextEditingController destCont,
//     required TextEditingController costCont,
//     required String startLat,
//     required String startLon,
//     required String destLat,
//     required String destLon,
//     required String paymentCont,
//     required String servType,
//   }) async {
//     try {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString("token"); // Retrieve the token
//       print('The token is $token');

//       Map<String, String> queryParameters = {
//         "startLat": startLat,
//         "startLon": startLon,
//         "destLat": destLat,
//         "destLon": destLon,
//         "expectedCost": costCont.text,
//         "paymentMethod": paymentCont,
//         "serviceType": servType,
//         "locationName": locationCont.text,
//         "destinationName": destCont.text,
//       };

//       // Encode requestBody to JSON
//       String jsonBody = jsonEncode(queryParameters);
//       print('Sending request with JSON body: $jsonBody');

//       // Build query string
//       String queryString = Uri(queryParameters: queryParameters).query;
//       String requestUrl = '$transportUrl?$queryString';

//       // Perform the GET request
//       final response = await http.get(
//         Uri.parse(requestUrl),
//         headers: {
//           "Authorization": "Bearer $token",
//         },
//       );

//       print('After sending request');
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         print('Request successful');
//         print(response.body);
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//         print(response.body);
//         _showErrorDialog(
//           context,
//           "Failed to send request. Please try again later.",
//           destCont,
//           locationCont,
//           costCont,
//           paymentCont,
//         );
//       }
//     } catch (error) {
//       print('Error: $error');
//       _showErrorDialog(
//         context,
//         "An unexpected error occurred. Please try again later.",
//         destCont,
//         locationCont,
//         costCont,
//         paymentCont,
//       );
//     }
//   }
// }

// void _showErrorDialog(
//   BuildContext context,
//   String message,
//   TextEditingController destination,
//   TextEditingController location,
//   TextEditingController cost,
//   String paymentCont,
// ) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         content: Text(
//           message,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 20,
//             fontFamily: 'Comfortaa',
//             color: Colors.black,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               destination.clear();
//               location.clear();
//               cost.clear();
//               Navigator.of(context).pop();
//             },
//             child: Container(
//               width: 120,
//               height: 45,
//               decoration: BoxDecoration(
//                 color: kPrimaryColor,
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               child: Center(
//                 child: Text(
//                   'Try Again',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontFamily: 'Comfortaa',
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
