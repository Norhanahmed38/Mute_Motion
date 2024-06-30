import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/core/utils/widgets/custom_button.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/create_Profile_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCardViewBody extends StatefulWidget {
  const AddCardViewBody({super.key});

  @override
  State<AddCardViewBody> createState() => _AddCardViewBodyState();
}

TextEditingController cardNumberController = TextEditingController();
TextEditingController expiryDateController = TextEditingController();
TextEditingController cvvController = TextEditingController();

class _AddCardViewBodyState extends State<AddCardViewBody> {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 440.h,
      width: 430.w,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      'Card Types Accepted',
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: 'Comfortaa',
                          color: Color(0xff003248)),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Image.asset('assets/images/visa.png'),
                    SizedBox(
                      width: 10.w,
                    ),
                    SizedBox(
                        height: 36.h,
                        width: 40.w,
                        child: Image.asset('assets/images/mastercard.png')),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Card Number',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'Comfortaa',
                    color: kPrimaryColor),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '2222 3333 4444 5555',
                  hintStyle: GoogleFonts.comfortaa(
                    color: Colors.black.withOpacity(0.65),
                    fontSize: 12.sp,
                  ),
                ),
                controller: cardNumberController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Card Number must not be empty";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30.h,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expiry Date',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Comfortaa',
                              color: kPrimaryColor),
                        ),
                        Container(
                          width: 150.w, // Set a finite width
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: '2 / 2025',
                              hintStyle: GoogleFonts.comfortaa(
                                color: Colors.black.withOpacity(0.65),
                                fontSize: 12.sp,
                              ),
                            ),
                            controller: expiryDateController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Expiry Date must not be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CVV',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'Comfortaa',
                            color: kPrimaryColor,
                          ),
                        ),
                        Container(
                          width: 150.w, // Set a finite width
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '123',
                              hintStyle: GoogleFonts.comfortaa(
                                color: Colors.black.withOpacity(0.65),
                                fontSize: 12.sp,
                              ),
                            ),
                            controller: cvvController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "CVV must not be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'We will securely store this card for a faster payment experience',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Comfortaa',
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                width: double.infinity,
                height: 58.h,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(15)),
                child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateProfileScreenView()));
                    },
                    child: Text(
                      "Add Card",
                      style: GoogleFonts.comfortaa(
                          fontSize: 20.sp, color: Colors.white),
                    )),
              ),
            ],
          ),
        ),
        // ),
      ),
    );
  }
}
