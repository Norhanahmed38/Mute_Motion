import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants.dart';
import '../../../mainMenu/presentation/views/mainMenu_screen_view.dart';
import '../../../trip_track/view/map_screen.dart';

class LoginUserApi {
  static const loginUserUrl =
      "https://mutemotion.onrender.com/api/v1/passenger/login";
  static const updateFcmTokenUrl =
      "https://mutemotion.onrender.com/api/v1/passenger/updateFCMToken";

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  LoginUserApi() {
    _initFirebaseMessaging();
    _initializeLocalNotifications();
  }

  BuildContext? get context => null;

  Future<void> userLogin({
    required BuildContext context,
    required TextEditingController emailcont,
    required TextEditingController passcont,
  }) async {
    try {
      String? fcmToken = await getFcmToken();
      if (fcmToken == null) {
        throw Exception("FCM token is null");
      }

      Map<String, dynamic> requestBody = {
        'email': emailcont.text,
        'password': passcont.text,
      };

      Response response = await Dio().post(loginUserUrl, data: requestBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        navigateTo(context, MainMenuScreenView());

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", response.data["token"]);
        await prefs.setString("_id", response.data["user"]["_id"]);
        await prefs.setString("firstname", response.data["user"]["firstname"]);
        await prefs.setString("email", response.data["user"]["email"]);

        await updateFcmToken(response.data["user"]["_id"], fcmToken);
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response?.data);
        _showErrorDialog(
            context, 'Email or password aren\'t correct', emailcont, passcont);
      }
    }
  }

  Future<String?> getFcmToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      print("FCM Token: $token");
      return token;
    } catch (e) {
      print("Failed to get FCM token: $e");
      return null;
    }
  }

  Future<void> updateFcmToken(String userId, String fcmToken) async {
    try {
      Map<String, dynamic> requestBody = {
        'userId': userId,
        'fcmToken': fcmToken,
      };

      Response response =
          await Dio().post(updateFcmTokenUrl, data: requestBody);
      if (response.statusCode == 200) {
        print("FCM token updated successfully");
      } else {
        print("Failed to update FCM token");
      }
    } catch (e) {
      print("Error updating FCM token: $e");
    }
  }

  void _showErrorDialog(
    BuildContext context,
    String message,
    TextEditingController emailcont,
    TextEditingController passCont,
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
                passCont.clear();
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

  void _initFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        _showNotification(
            message.notification!.title, message.notification!.body);

        // Check for the specific notification message and navigate accordingly
        if (message.notification!.body ==
            'Your ride request has been accepted by the driver.') {
//           navigateToRouteScreen();

//           navigateToMapScreen(); // Navigate to map screen
 
        }
      }
      print(message.notification!.body);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      _showNotification(
          message.notification!.title, message.notification!.body);

      // Check for the specific notification message and navigate accordingly
      if (message.notification!.body ==
          'Your ride request has been accepted by the driver.') {
        navigateToRouteScreen();
      }
      // Handle the notification tapped logic here
    });

  }

  void navigateToRouteScreen() {
    Navigator.push(
      context!,
      MaterialPageRoute(
        builder: (context) => RouteScreen(

        ),
      ),
    );
  }

  void navigateToMapScreen() {
    print('Navigating to Map Screen automatically...');
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
}

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: Center(
        child: Text(
          'This is the Map Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
