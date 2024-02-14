import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/widgets/forget_pass.dart';

class ResendPassApi {
  static const resendPassUrl = "https://mutemotion.onrender.com/api/v1/passenger/sendagain";
  resendPass(
      {required BuildContext context,
      required TextEditingController emailcont,
      }) async {
    try {
      print('before');
      Map<String, dynamic> requestBody = {
        'email': emailcont.text,
        
      };
      Response response = await Dio().post("$resendPassUrl", data: requestBody);
      print('after');
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        
        
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response?.data);
        _showErrorDialog(
            context, 'Email not Found', emailcont);
      }
    }
  }
}

void _showErrorDialog(
  BuildContext context,
  String message,
  TextEditingController emailcont,
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
              emailcont.clear();
          
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
                padding:  EdgeInsets.only(top: 5),
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
