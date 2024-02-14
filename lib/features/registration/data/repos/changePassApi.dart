import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/login_screen_view.dart';

class ChangePassApi {
  static const changePassUrl = "https://mutemotion.onrender.com/api/v1/passenger/changepassword";
  changePass(
      {required BuildContext context,
      required TextEditingController emailcont,
      required TextEditingController code1,
      required TextEditingController code2,
      required TextEditingController code3,
      required TextEditingController code4,
      required TextEditingController passcont,
      }) async {
    try {
      print('before');
      Map<String, dynamic> requestBody = {
        "email":emailcont.text,
        "verificationCode":'${code1.text}${code2.text}${code3.text}${code4.text}',
        "newPassword":passcont.text,
        
      };
      Response response = await Dio().post("$changePassUrl", data: requestBody);
      print('after');
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        navigateTo(
          context,
          LoginScreenView(),
        );
        
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response?.data);
        _showErrorDialog(
            context, "Email or code aren't correct", emailcont,code1,code2,code3,code4,passcont);
      }
    }
  }
}

void _showErrorDialog(
   BuildContext context,
   String message,
    TextEditingController emailcont,
       TextEditingController code1,
       TextEditingController code2,
       TextEditingController code3,
       TextEditingController code4,
       TextEditingController passcont,
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

              code1.clear();
              code2.clear();
              code3.clear();
              code4.clear();
              passcont.clear();

          
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
