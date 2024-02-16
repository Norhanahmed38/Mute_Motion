import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/core/utils/widgets/custemcodefield.dart';
import 'package:mute_motion_passenger/features/registration/data/repos/changePassApi.dart';
import 'package:mute_motion_passenger/features/registration/data/repos/login_user.dart';
import 'package:mute_motion_passenger/features/registration/data/repos/resend_pass_code.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ForgotPasswordBody extends StatefulWidget {
  const ForgotPasswordBody({super.key});

  @override
  State<ForgotPasswordBody> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordBody> {
  bool _isLoading = false;
  bool Show_Pass = true;
  bool Show_VerifPass = true;
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  TextEditingController verifpassCont = TextEditingController();
  final TextEditingController code1 = TextEditingController();

  final TextEditingController code2 = TextEditingController();

  final TextEditingController code3 = TextEditingController();

  final TextEditingController code4 = TextEditingController();
  bool _visible = false;
  final CountdownController counterCont = CountdownController(autoStart: true);
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: kPrimaryColor,
      inAsyncCall: _isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 5,
                ),
                const Center(
                    child: Text("Reset Your Password",
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor))),
                Divider(thickness: 2),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "Please enter the 4-digit code sent via email to\n ${getUserEmail()}",
                  style:
                      GoogleFonts.comfortaa(color: kPrimaryColor, fontSize: 15),
                ),
                const SizedBox(
                  height: 25,
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
                  height: 25,
                ),
                TextFormField(
                  controller: emailCont,
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
                    label: Text(
                      "Email",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    prefixIcon: Icon(Icons.mail),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                    prefixIconColor: kPrimaryColor,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                TextFormField(
                  controller: passCont,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password must not be empty";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: Show_Pass,
                  decoration: InputDecoration(
                    label: const Text(
                      "New Password",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                    prefixIconColor: kPrimaryColor,
                    suffixIconColor: kPrimaryColor,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          Show_Pass = !Show_Pass;
                        });
                      },
                      icon: Icon(
                          Show_Pass ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: verifpassCont,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This field must not be empty";
                    } else if (verifpassCont.text != passCont.text) {
                      return "Passwords aren't identical";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: Show_VerifPass,
                  decoration: InputDecoration(
                    label: const Text(
                      "Verify your Password",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                    prefixIconColor: kPrimaryColor,
                    suffixIconColor: kPrimaryColor,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          Show_VerifPass = !Show_VerifPass;
                        });
                      },
                      icon: Icon(Show_VerifPass
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 58,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xff003248),
                      borderRadius: BorderRadius.circular(20)),
                  child: MaterialButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });

                          await ChangePassApi().changePass(
                              code1: code1,
                              code2: code2,
                              code3: code3,
                              code4: code4,
                              context: context,
                              emailcont: emailCont,
                              passcont: passCont);
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      child: const Text(
                        "Reset your Password",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Comfortaa',
                            color: Colors.white),
                      )),
                ),
                const SizedBox(
                  height: 15,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("The code will expire automatically in ",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Comfortaa',
                          )),
                      Countdown(
                        controller: counterCont,
                        seconds: 300,
                        build: (BuildContext context, double time) =>
                            Text(time.toString()),
                        interval: Duration(milliseconds: 100),
                        onFinished: () {
                          setState(() {});
                          _visible = true;
                          print('Timer is done!');
                        },
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: _visible,
                  child: TextButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await ResendPassApi()
                            .resendPass(context: context, emailcont: emailCont);
                        setState(() {
                          _isLoading = false;
                        });
                        counterCont.restart();

                        //_visible= false;
                      },
                      child: const Text(
                        "Resend Password",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 16,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
