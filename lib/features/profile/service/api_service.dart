import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mute_motion_passenger/features/profile/model/model.dart';

class ApiService {
  static Future<UserModel> fetchUserData(String token) async {
    Dio dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response =
        await dio.get('https://mutemotion.onrender.com/api/passengerInfo');
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Request successful');
      print(response.data);
      Map<String, dynamic> userDataMap =
          Map<String, dynamic>.from(response.data);
      return UserModel.fromJson(userDataMap);
    } else {
      throw Exception('Failed to load user data');
    }
  }
}
