import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/navdrawer/presentation/views/nav_drawer_view.dart';
import 'package:mute_motion_passenger/features/payment/data/payment_api.dart';

import 'package:mute_motion_passenger/features/payment/persentation/widgets/CustomTextFormField.dart';

class PaymentBody extends StatefulWidget {
  PaymentBody({super.key});

  @override
  State<PaymentBody> createState() => _PaymentBodyState();
}

class _PaymentBodyState extends State<PaymentBody> {
  var formKey = GlobalKey<FormState>();

  TextEditingController cardNumController = TextEditingController();
  TextEditingController ccvvController = TextEditingController();
  TextEditingController expdateController = TextEditingController();
  TextEditingController moneyController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        drawer: const NavDrawerView(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            'Wallet',
            style: TextStyle(
                fontSize: 21.sp, fontFamily: 'Lato', color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.89,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.w),
                topRight: Radius.circular(20.w),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 25.h),
                    Image.asset(
                      'assets/images/visssa.PNG',
                      height: 110.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      "please Enter your card details to add money to your wallet",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.comfortaa(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    CustomTextFormField(
                      controller: cardNumController,
                      hintText: '2222 3333 4444 5555',
                      labelText: 'Card Number',
                      validatorMessage: 'Card Number must not be empty',
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 150.w,
                          child: CustomTextFormField(
                            controller: expdateController,
                            hintText: '2 / 2025',
                            labelText: 'Expiry Date',
                            validatorMessage: 'Expiry Date must not be empty',
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Container(
                          width: 150.w,
                          child: CustomTextFormField(
                            controller: ccvvController,
                            hintText: '123',
                            labelText: 'CVV',
                            validatorMessage: 'CVV must not be empty',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextFormField(
                      controller: moneyController,
                      hintText: '200',
                      labelText: 'Amount of money',
                      validatorMessage: 'Amount of money must not be empty',
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        backgroundColor: kPrimaryColor,
                        minimumSize: Size(400.w, 55.h),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          await PaymentAPI().payment(
                            context: context,
                            cardCont: cardNumController,
                            cvvCont: ccvvController,
                            dateCont: expdateController,
                            amountCont: moneyController,
                          );

                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      child: Text(
                        'Withdraw ',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
