import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/core/utils/widgets/custom_button.dart';
import 'package:mute_motion_passenger/features/registration/data/repos/verification.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/OTP_screen_view.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/login_screen_view.dart';

class RegisterScreenViewBody extends StatefulWidget {
  RegisterScreenViewBody({super.key});

  @override
  State<RegisterScreenViewBody> createState() => _RegisterScreenViewBodyState();
}

class _RegisterScreenViewBodyState extends State<RegisterScreenViewBody> {
  bool _isLoading = false;

  final TextEditingController emailController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Enter Email',
            style: GoogleFonts.lato(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Please enter your Email to contact us ',
                      style: GoogleFonts.comfortaa(
                        fontSize: 14.5,
                        color: kPrimaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!);
                        if (value!.isEmpty) {
                          return "Email can't be empty";
                        } else if (emailValid == false) {
                          return "Email format not valid";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "passenger@gmail.com",
                        suffixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
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
                            Verification()
                                .sendVerification(email: emailController.text);
                            setUserEmail(emailController.text);
                            navigateTo(
                              context,
                              OTPScreenView(),
                            );
                          }
                          setState(() {
                            _isLoading = false;
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
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        navigateTo(context, LoginScreenView());
                      },
                      child: Text(
                        'Already have an account',
                        style: GoogleFonts.comfortaa(
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    /* Divider(),
                    Text(
                      'or',
                      style: GoogleFonts.comfortaa(
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 58,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.solidEnvelope),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Continue with Email',
                              style: GoogleFonts.comfortaa(
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 58,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.apple),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Continue with Apple',
                              style: GoogleFonts.comfortaa(
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 58,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.google),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Continue with Google',
                              style: GoogleFonts.comfortaa(
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ), */
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
