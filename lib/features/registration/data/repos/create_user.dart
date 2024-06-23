import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/OTP_screen_view.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/create_Profile_screen.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/widgets/add_card_view_body.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/widgets/create_profile_screen_Body.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateUserAPI {
  static const String baseUrl = 'https://mutemotion.onrender.com/api/';
  static const String createUserUrl = "${baseUrl}v1/passenger/signup";

  Future<void> createUser({
    required BuildContext context,
    required TextEditingController firstnameCont,
    required TextEditingController lastnameCont,
    required TextEditingController emailCont,
    required TextEditingController passwordCont,
    required TextEditingController passwordConfirmCont,
    required TextEditingController cardNumberCont,
    required TextEditingController expiryDateCont,
    required TextEditingController cvvCont,
    required String genderCont,
    required TextEditingController phoneCont,
  }) async {
    try {
      print('before');
      Map<String, dynamic> requestBody = {
        "firstname": firstnameCont.text,
        "lastname": lastnameCont.text,
        "email": emailCont.text,
        "password": passwordCont.text,
        "passwordConfirm": passwordConfirmCont.text,
        "CardNumber": cardNumberCont.text,
        "ExpiryDate": expiryDateCont.text,
        "CVV": cvvCont.text,
        "gender": genderCont,
        "phone": phoneCont.text,
      };

      Response response = await Dio().post(createUserUrl, data: requestBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        setUserEmail(emailCont.text);
        navigateTo(
          context,
          OTPScreenView(),
        );
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("_id", response.data["user"]["_id"]);
        String? id = prefs.getString("_id");
        print("Id is : $id");

        print("after");
      } else if (response.statusCode == 400) {
        print('Request failed with status: ${response.statusCode}');
        print('Response: ${response.data}');
        _showErrorDialog(
            context,
            "This Email Already Exists",
            firstName,
            lastName,
            email,
            pass,
            verifPass,
            cardNumberController,
            expiryDateController,
            cvvController,
            phone);

        print('Request failed with status: ${response.statusCode}');
        print('Response: ${response.data}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}

void _showErrorDialog(
  BuildContext context,
  String message,
  TextEditingController firstName,
  TextEditingController lastName,
  TextEditingController email,
  TextEditingController pass,
  TextEditingController verifPass,
  TextEditingController cardNumberController,
  TextEditingController expiryDateController,
  TextEditingController cvvController,
  TextEditingController phone,
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
              firstName.clear();
              lastName.clear();
              email.clear();
              verifPass.clear();
              cardNumberController.clear();
              expiryDateController.clear();
              cvvController.clear();
              pass.clear();
              phone.clear();
              Navigator.of(context).pop();
              navigateTo(context, CreateProfileScreenView());
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
