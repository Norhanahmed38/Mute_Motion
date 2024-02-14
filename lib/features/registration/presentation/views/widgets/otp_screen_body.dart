import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/core/utils/widgets/custom_button.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/create_Profile_screen.dart';

import '../../../../../core/utils/widgets/custemOTPbar.dart';

import '../../../../../core/utils/widgets/custemcodefield.dart';
import '../../../data/repos/verification.dart';

class OTPScreenBody extends StatefulWidget {
  OTPScreenBody({super.key});

  @override
  State<OTPScreenBody> createState() => _OTPScreenBodyState();
}

class _OTPScreenBodyState extends State<OTPScreenBody> {
  String? email = getUserEmail();
  bool _isLoading = false;

  var formKey = GlobalKey<FormState>();

  final TextEditingController code1 = TextEditingController();

  final TextEditingController code2 = TextEditingController();

  final TextEditingController code3 = TextEditingController();

  final TextEditingController code4 = TextEditingController();

  String verifyCodeUrl =
      'https://mutemotion.onrender.com/api/v1/passenger/verify';

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              iconSize: 30,
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const CreateProfileScreenView()));
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: kPrimaryColor,
              )),
          title: Text(
            'OTP Verification',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              color: kPrimaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 56,
                  ),
                  Text(
                    "Please enter the 4-digit code sent via email on\n ${getUserEmail()}",
                    style: GoogleFonts.comfortaa(
                        color: kPrimaryColor, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              const CreateProfileScreenView()));
                    },
                    child: Text(
                      "Edit your Email",
                      style: GoogleFonts.comfortaa(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 71,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      custemcodefield(
                        controller: code1,
                      ),
                      custemcodefield(
                        controller: code2,
                      ),
                      custemcodefield(
                        controller: code3,
                      ),
                      custemcodefield(
                        controller: code4,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 79,
                  ),
                  Container(
                    height: 58,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          Verification().verifyCode(
                              email: getUserEmail()!,
                              code1: code1,
                              code2: code2,
                              code3: code3,
                              code4: code4,
                              context: context);
                        }
                        setState(() {
                          _isLoading = true;
                        });
                      },
                      child: Text(
                        'Continue',
                        style: GoogleFonts.comfortaa(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Haven’t received OTP code? ",
                            style: GoogleFonts.comfortaa(
                              fontSize: 12,
                            )),
                        TextButton(
                            onPressed: () {
                              Verification().sendVerification(email: email!);
                            },
                            child: Text(
                              "Resend OTP",
                              style: GoogleFonts.comfortaa(
                                  color: kPrimaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
