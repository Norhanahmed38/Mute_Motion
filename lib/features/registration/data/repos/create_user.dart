import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/mainMenu/presentation/views/mainMenu_screen_view.dart';
import 'package:mute_motion_passenger/features/registration/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CreateUser {
  Future<void> signupPostRequest(SignUpModel model) async {
    String baseUrl =
        'https://gradution2024-production.up.railway.app/api/v1/passengers';
    Uri url = Uri.parse('${baseUrl}');
    String jsonStu = jsonEncode(model);
    print(jsonStu);
    var response = await http.post(url, body: jsonStu);
    if (response.statusCode == 201 || response.statusCode == 200) {
      print("Successful Response");
    } else {
      print("Unsuccessful Response");
      print(response.body);
      print(jsonStu);
    }
  }
}
