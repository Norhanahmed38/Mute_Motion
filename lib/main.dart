import 'package:flutter/material.dart';

import 'package:mute_motion_passenger/features/registration/presentation/views/create_Profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /* theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kPrimaryColor,
       
      ), */
      debugShowCheckedModeBanner: false,
      home: CreateProfileScreenView(),
    );
  }
}
//home: Splach,
