import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/OTP_screen_view.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/create_Profile_screen.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/widgets/add_card_view_body.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/widgets/create_profile_screen_Body.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateUserAPI {
  static const String baseUrl = 'https://mutemotion.onrender.com/api/v1';
  static const String createUserUrl = "${baseUrl}/passenger/signup";
  
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  CreateUserAPI() {
    _initFirebaseMessaging();
    _initializeLocalNotifications();
  }

  void _initializeLocalNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _initFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        _showNotification(
            message.notification!.title, message.notification!.body);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Handle the notification tapped logic here
    });
  }

  Future<void> _showNotification(String? title, String? body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  Future<String?> getFcmToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? token = await messaging.getToken();
      print("FCM Token: $token");
      return token;
    } catch (e) {
      print("Failed to get FCM token: $e");
      return null;
    }
  }

  Future<void> updateFCMToken({required String userId, required String fcmToken}) async {
    try {
      Map<String, dynamic> requestBody = {
        "userId": userId,
        "fcmToken": fcmToken,
      };
        print(requestBody);
      Response response = await Dio().post("${baseUrl}/passenger/updateFCMToken", data: requestBody);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('FCM token updated successfully');
      } else {
        print('Failed to update FCM token: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        print('Dio error: ${e.response?.data}');
      } else {
        print('Request failed with error: $e');
      }
    }
  }

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
      String? fcmToken = await getFcmToken();
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
        await updateFCMToken(userId: response.data["user"]["_id"], fcmToken: fcmToken!);
        String? id = prefs.getString("_id");
        print("Id is : $id");

        print("after");
      } else if (response.statusCode == 400) {
        print('Request failed with status: ${response.statusCode}');
        print('Response: ${response.data}');
        _showErrorDialog(
            context,
            "This Email Already Exists",
            firstnameCont,
            lastnameCont,
            emailCont,
            passwordCont,
            passwordConfirmCont,
            cardNumberCont,
            expiryDateCont,
            cvvCont,
            phoneCont);

        print('Request failed with status: ${response.statusCode}');
        print('Response: ${response.data}');
      }
    } catch (error) {
      if (error is DioException) {
        print('DioException: ${error.response?.data}');
        if (error.response?.statusCode == 400) {
          _showErrorDialog(
            context,
            "This Email Already Exists",
            firstnameCont,
            lastnameCont,
            emailCont,
            passwordCont,
            passwordConfirmCont,
            cardNumberCont,
            expiryDateCont,
            cvvCont,
            phoneCont,
          );
        }
      } else {
        print('Error: $error');
      }
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
