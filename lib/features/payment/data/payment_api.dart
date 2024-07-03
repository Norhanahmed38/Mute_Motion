import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mute_motion_passenger/features/payment/persentation/paymentCompletedview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentAPI {
  static const Url = "https://mutemotion.onrender.com/api/v1/passenger/charge";
  payment({
    required BuildContext context,
    required TextEditingController cardCont,
    required TextEditingController cvvCont,
    required TextEditingController dateCont,
    required TextEditingController amountCont,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        print("Token is null");
        return;
      }
      Map<String, dynamic> requestBody = {
        "cardNumber": cardCont.text,
        'cvv': cvvCont.text,
        'expiryDate': dateCont.text,
        "amount": amountCont.text,
      };
      Response response = await Dio().post(
        Url,
        data: requestBody,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        print(requestBody);
        String transactionId = response.data['paymentResult']['transactionId'];
        _showErrorDialog(
            context,
            'Successful operation with a transaction_ID $transactionId',
            cardCont,
            cvvCont,
            dateCont,
            amountCont);
        navigateTo(context, paymentCompletedview());

        print("after");
      }
    } catch (e) {
      if (e is DioException) {
        print(e.response?.data);
        print(e);
        _showErrorDialog(context, 'An error happened, please try again later',
            cardCont, cvvCont, dateCont, amountCont);
      }
    }
  }
}

void _showErrorDialog(
  BuildContext context,
  String message,
  TextEditingController cardCont,
  TextEditingController cvvCont,
  TextEditingController dateCont,
  TextEditingController amountCont,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20.sp, fontFamily: 'Comfortaa', color: kPrimaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () {
              cardCont.clear();
              cvvCont.clear();
              dateCont.clear();
              amountCont.clear();
              Navigator.of(context).pop();
            },
            child: Container(
              width: 120.w,
              height: 45.h,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'OK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.sp,
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
