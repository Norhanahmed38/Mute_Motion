import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/core/styles.dart';
import 'package:mute_motion_passenger/core/utils/widgets/customtextfield.dart';
import 'package:mute_motion_passenger/features/registration/data/repos/create_user.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/OTP_screen_view.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/add_card_view.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/create_Profile_screen.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/login_screen_view.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/widgets/add_card_view_body.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/widgets/custom_drop_down.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateProfileScreenBody extends StatefulWidget {
  CreateProfileScreenBody({super.key});

  @override
  State<CreateProfileScreenBody> createState() =>
      _CreateProfileScreenBodyState();
}

final _api = CreateUserAPI();
final TextEditingController firstName = TextEditingController();
final TextEditingController lastName = TextEditingController();
final TextEditingController email = TextEditingController();
final TextEditingController phone = TextEditingController();
final TextEditingController pass = TextEditingController();
final TextEditingController verifPass = TextEditingController();

class _CreateProfileScreenBodyState extends State<CreateProfileScreenBody> {
  var formKey = GlobalKey<FormState>();

  bool showPassword = true;
  bool _isLoading = false;

  bool showVerifPassword = true;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(360, 680),
    );
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              iconSize: 25.sp,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreenView()));
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: kPrimaryColor,
              )),
          title: Text(
            'Create Your Profile',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
                fontSize: 20.sp),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Welcome,',
                        style:
                            Styles.textStyle15.copyWith(color: kPrimaryColor),
                      ),
                      Text(
                        'Let us know some information about you!!',
                        style: Styles.textStyle15
                            .copyWith(fontSize: 12.sp, color: kPrimaryColor),
                      ),
                      SizedBox(
                        height: 45.h,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(
                              20,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 60.h),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 45.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white,
                                  ),
                                  child: CustomTextField(
                                    obscureText: false,
                                    controller: firstName,
                                    hintText: 'First name',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white,
                                  ),
                                  child: CustomTextField(
                                    obscureText: false,
                                    controller: lastName,
                                    hintText: 'Last name',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: email,
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
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      hintStyle: GoogleFonts.comfortaa(
                                        color: Colors.black.withOpacity(0.65),
                                        fontSize: 12.sp,
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: phone,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Phone can't be empty";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Phone',
                                      hintStyle: GoogleFonts.comfortaa(
                                        color: Colors.black.withOpacity(0.65),
                                        fontSize: 12.sp,
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white,
                                  ),
                                  child: TextFormField(
                                    obscureText: showPassword,
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: pass,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Password must not be empty";
                                      } else if (value.length < 6) {
                                        return "Password can't be less than 6 letters";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(showPassword
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                        onPressed: () {
                                          setState(() {
                                            showPassword = !showPassword;
                                          });
                                        },
                                      ),
                                      hintText: 'password',
                                      hintStyle: GoogleFonts.comfortaa(
                                        color: Colors.black.withOpacity(0.65),
                                        fontSize: 12.sp,
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white,
                                  ),
                                  child: TextFormField(
                                    obscureText: showVerifPassword,
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: verifPass,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Can\'t be Empty';
                                      } else if (pass.text != verifPass.text) {
                                        return 'Passwords aren\'t identical';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(showVerifPassword
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                        onPressed: () {
                                          setState(() {
                                            showVerifPassword =
                                                !showVerifPassword;
                                          });
                                        },
                                      ),
                                      hintText: 'Verify your password',
                                      hintStyle: GoogleFonts.comfortaa(
                                        color: Colors.black.withOpacity(0.65),
                                        fontSize: 12.sp,
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              CustomDropDown(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Add Credit Card',
                                          style: GoogleFonts.comfortaa(
                                            color:
                                                Colors.black.withOpacity(0.65),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            buildShowModalBottomSheet(context);
                                          },
                                          icon: Icon(Icons.arrow_right)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 22.w, left: 10.w),
                        //padding: EdgeInsets.all(8),
                        width: double.infinity,
                        height: 58.h,
                        decoration: BoxDecoration(
                            color: const Color(0xff003248),
                            borderRadius: BorderRadius.circular(15.r)),
                        child: MaterialButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              await _api.createUser(
                                context: context,
                                firstnameCont: firstName,
                                lastnameCont: lastName,
                                emailCont: email,
                                passwordCont: pass,
                                passwordConfirmCont: verifPass,
                                cardNumberCont: cardNumberController,
                                expiryDateCont: expiryDateController,
                                cvvCont: cvvController,
                                genderCont: dropdownValue!,
                                phoneCont: phone,
                              );
                            }
                            setState(() {
                              _isLoading = false;
                            });
                          },
                          child: Text(
                            "Register",
                            style: GoogleFonts.comfortaa(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 645.h,
                    left: 130.w,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/person.png'),
                      radius: 50.r,
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

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: AddCardView(),
          );
        });
  }
}
