import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/navdrawer/presentation/views/nav_drawer_view.dart';

class WebBody extends StatefulWidget {
  const WebBody({super.key});

  @override
  State<WebBody> createState() => _WebBodyState();
}

class _WebBodyState extends State<WebBody> {
  final String lineToCopy =
      "https://667f3e3182106b9d52b9b9d9--mutemotion.netlify.app/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawerView(),
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Learn Sign Language',
          style: GoogleFonts.comfortaa(fontSize: 20, color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 41),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Image(
                  width: 348,
                  height: 325,
                  image: AssetImage(
                    "assets/images/SPLASH1.jpg",
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Center(
                  child: Text(
                    "Widen Your Horizon",
                    style: GoogleFonts.comfortaa(
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    "Learn Sign Language on our Website to Better Connect with Our Deaf Drivers",
                    style: GoogleFonts.comfortaa(
                      //fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.125,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 58,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: MaterialButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: lineToCopy));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Link copied to your clipboard')),
                        );
                      },
                      child: Text(
                        "Copy link",
                        style: GoogleFonts.comfortaa(
                            fontSize: 20, color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.125,
                ),
              ],
            ),
          ),
        ),
      ),
      /*  Center(
        child: GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: lineToCopy));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Link copied to your clipboard')),
            );
          },
          child: Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.blueAccent,
            child: Text(
              'SS',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        ),
      ), */
    );
  }
}
