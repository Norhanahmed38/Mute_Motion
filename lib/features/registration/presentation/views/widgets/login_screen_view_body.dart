import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/registration/data/repos/forgotyourPass.dart';
import 'package:mute_motion_passenger/features/registration/data/repos/login_user.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/create_Profile_screen.dart';
import '../../../../mainMenu/presentation/views/mainMenu_screen_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreenViewBody extends StatefulWidget {
  const LoginScreenViewBody({super.key});

  @override
  State<LoginScreenViewBody> createState() => _LoginScreenViewBodyState();
}

class _LoginScreenViewBodyState extends State<LoginScreenViewBody> {
  bool _isLoading = false;
  bool Show_Pass = true;
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
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
                SizedBox(
                  height: 5.h,
                ),
                Center(
                    child: Text("Login",
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor))),
                Divider(thickness: 2),
                SizedBox(
                  height: 25.h,
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
                SizedBox(
                  height: 15.h,
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
                      "Password",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      ),
                    ),
                    border: OutlineInputBorder(
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
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () async {
                      setUserEmail(emailCont.text);
                      setState(() {
                        _isLoading = true;
                      });
                      await ForgotPassApi()
                          .forgotPass(context: context, emailcont: emailCont);
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    child: Text(
                      "Forgot Your Password",
                      style: TextStyle(
                          color: Colors.red[900],
                          fontSize: 16,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  height: 58.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xff003248),
                      borderRadius: BorderRadius.circular(20.r)),
                  child: MaterialButton(
                      onPressed: () async {
                        print(emailCont.text);
                        print(passCont.text);
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          setUserEmail(emailCont.text);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('email', emailCont.text);
                          await LoginUserApi().userLogin(
                              context: context,
                              emailcont: emailCont,
                              passcont: passCont);
                        }
                        setState(() {
                          _isLoading = false;
                        });
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: 'Comfortaa',
                            color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? ",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: 'Comfortaa',
                          )),
                      TextButton(
                          onPressed: () {
                            navigateTo(
                              context,
                              CreateProfileScreenView(),
                            );
                          },
                          child: Text(
                            "Register now",
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 16.sp,
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
