import 'package:flutter/material.dart';

import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/core/utils/widgets/custom_map.dart';
import 'package:mute_motion_passenger/core/utils/widgets/custom_map.dart';
import 'package:mute_motion_passenger/features/aboutUs/presentation/views/aboutUs_screen_view.dart';
import 'package:mute_motion_passenger/features/history/presentation/views/history_screen_view.dart';
import 'package:mute_motion_passenger/features/navdrawer/presentation/views/widgets/pages.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/login_screen_view.dart';
import 'package:mute_motion_passenger/features/requests/presentation/views/requests_view.dart';
import 'package:mute_motion_passenger/features/translator/presentation/views/translator_view.dart';
import 'package:mute_motion_passenger/features/navdrawer/presentation/views/widgets/headwidget.dart';
import 'package:mute_motion_passenger/features/web%20page/webpage_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../contactUs/presentation/views/contact_us_screenView.dart';

class NavDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Drawer(
      child: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: SingleChildScrollView(
          child: Column(children: [
            HadWidget(
              darkGreen: kPrimaryColor,
            ),
            SizedBox(
              height: 45,
            ),
            Container(
              child: Column(
                children: [
                  pages(
                      darkGreen: kPrimaryColor,
                      pagename: 'Map',
                      icone: Icons.map_outlined,
                      onpressed: () {
                        navigateTo(context, MapScreen());
                      }),
                  Divider(
                    indent: 20,
                    endIndent: 30,
                    color: kPrimaryColor,
                    thickness: 1,
                    height: 2,
                  ),
                  pages(
                      darkGreen: kPrimaryColor,
                      pagename: 'Interpreter Mode',
                      icone: Icons.camera_alt_rounded,
                      onpressed: () {
                        navigateTo(context, TranslatorView());
                      }),

                  Divider(
                    indent: 20,
                    endIndent: 30,
                    color: kPrimaryColor,
                    thickness: 1,
                    height: 2,
                  ),
                  pages(
                      darkGreen: kPrimaryColor,
                      pagename: 'Learn Sign Language',
                      icone: Icons.sign_language,
                      onpressed: () async {
                        navigateTo(context, WebPageScreen());
                      }),
                  Divider(
                    indent: 20,
                    endIndent: 30,
                    color: kPrimaryColor,
                    thickness: 1,
                    height: 2,
                  ),
                  pages(
                      darkGreen: kPrimaryColor,
                      pagename: 'About us',
                      icone: Icons.album_outlined,
                      onpressed: () {
                        navigateTo(context, AboutUsScreenView());
                      }),
                  Divider(
                    indent: 20,
                    endIndent: 30,
                    color: kPrimaryColor,
                    thickness: 1,
                    height: 2,
                  ),
                  pages(
                      darkGreen: kPrimaryColor,
                      pagename: 'Contact us',
                      icone: Icons.contact_support,
                      onpressed: () {
                        navigateTo(context, ContactUsScreenView());
                      }),
                  Divider(
                    indent: 20,
                    endIndent: 30,
                    color: kPrimaryColor,
                    thickness: 1,
                    height: 2,
                  ),

                  pages(
                      darkGreen: kPrimaryColor,
                      pagename: 'Logout',
                      icone: Icons.logout,
                      onpressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove('email');
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                LoginScreenView(),
                          ),
                          (Route route) => false,
                        );
                      }),

                  // navigateTo(context, ContactUsScreenView());
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
