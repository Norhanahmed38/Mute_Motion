import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/contactUs/presentation/views/contact_us_screenView.dart';
import 'package:mute_motion_passenger/features/deleting_account/data/delete_account_api.dart';
import 'package:mute_motion_passenger/features/navdrawer/presentation/views/nav_drawer_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart'; // Import ModalProgressHUD

import 'widgets/cansel_button.dart';
import 'widgets/delete_button.dart';

class DeleteAccountScreen extends StatefulWidget {
  @override
  _DeleteAccountScreenState createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  bool _isLoading = false; // State variable for loading indicator

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading, // Use the state variable
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        drawer: NavDrawerView(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Delete My Account',
            style: TextStyle(
                fontSize: 20.sp, fontFamily: 'Lato', color: Colors.white),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity.w,
          padding: EdgeInsets.only(top: 50.h, left: 15.w, right: 15),
          decoration: BoxDecoration(
              color: Color(0xffF4F4F4),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              )),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.warning_rounded,
                      color: Colors.red,
                      size: 30, // Adjust size to your liking
                    ),
                    SizedBox(width: 3),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Deleting your account will:",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  "          - Delete your account info and profile photo\n"
                  "          - Remove all your data\n"
                  "          - Delete your messages history\n"
                  "          - Delete your requests history\n",
                  style: TextStyle(fontSize: 16, color: kPrimaryColor),
                ),
                SizedBox(height: 50),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      deleteAccBtn(
                        text: 'Delete My Account',
                        width: double.infinity.w,
                        height: 60.h,
                        color: Colors.white,
                        textColor: Colors.red,
                        onTap: () async {
                          setState(() {
                            _isLoading = true; // Show the loader
                          });
                          try {
                            await AccountApi().deletePassengerAccount(
                              context: context,
                            );
                          } finally {
                            setState(() {
                              _isLoading = false; // Hide the loader
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        width: double.infinity.w,
                        height: 60.h,
                        child: canselBtn(
                          text: 'Cancel',
                          onTap: () {
                            navigateTo(context, NavDrawerView());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
