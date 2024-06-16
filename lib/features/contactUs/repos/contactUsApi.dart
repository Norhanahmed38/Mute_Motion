import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactUsAPI {
  static const contactUSUrl =
      "${baseUrl}contact";
  contactUs(
      {required BuildContext context,
       required TextEditingController nameCont,
      required TextEditingController emailCont,
      required TextEditingController phoneCont,
      required TextEditingController msgCont,}) async {
    try {
      print('before');
      Map<String, dynamic> requestBody = {
        "name":nameCont.text,
        'email': emailCont.text,
        'phone': phoneCont.text,
        "message" : msgCont.text,
      };
      Response response = await Dio().post("$contactUSUrl", data: requestBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
       _showErrorDialog(
            context, 'Thank you for your feedback', nameCont, emailCont,phoneCont,msgCont);
        
        print("after");
        
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response?.data);
        _showErrorDialog(
            context, 'An error happened, please try again later', nameCont, emailCont,phoneCont,msgCont);
      }
    }
  }
}

void _showErrorDialog(
  BuildContext context,
  String message,
  TextEditingController nameCont,
  TextEditingController emailCont,
  TextEditingController phoneCont,
  TextEditingController msgCont,
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
              nameCont.clear();
              emailCont.clear();
              phoneCont.clear();
              msgCont.clear();
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Container(
              width: 120,
              height: 55,
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