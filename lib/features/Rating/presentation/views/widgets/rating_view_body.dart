import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mute_motion_passenger/constants.dart';

import '../../../data/rating_api.dart';

class RatingViewBody extends StatefulWidget {
  const RatingViewBody({super.key});

  @override
  State<RatingViewBody> createState() => _RatingViewBodyState();
}

class _RatingViewBodyState extends State<RatingViewBody> {
  String rating = '0';
  String rateComment = 'Please rate the driver';

  bool ratingSubmitted = false; // Track if the rating was submitted


  void handleRatingSuccess() {
    setState(() {
      ratingSubmitted = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          title: Text(
            'Rate',
            style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
          ),
          leading: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 30,
              left: 15,
            ),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Text(
                    'Provide your feedback about your ride with this driver',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(fontSize: 18, color: kPrimaryColor,fontWeight: FontWeight.bold ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  RatingBar.builder(
                    glow: true,
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => FaIcon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (value) {
                      setState(() {
                        rating = value.toString();
                        if (value == 0) {
                          rateComment = 'Please rate the driver';
                        }else if (value == 1) {
                          rateComment = 'Awful';
                        } else if (value < 3) {
                          rateComment = 'Weak';
                        } else if (value < 4.5) {
                          rateComment = 'Good';
                        } else {
                          rateComment = 'Excellent';
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '$rateComment',
                    style: TextStyle(
                        fontSize: 24, fontFamily: 'Lato', color: kPrimaryColor),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  // Text(
                  //   'You rated your Driver',
                  //   style: GoogleFonts.lato(fontSize: 14, color: kPrimaryColor),
                  // ),
                  SizedBox(
                    height: 70,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(20.0),
                  //   child: TextFormField(
                  //     style: TextStyle(
                  //       fontSize: 18.0, // Set the font size
                  //       // You can also set other style properties here
                  //     ),
                  //     decoration: InputDecoration(
                  //       hintText: 'Your comment',
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10.0),
                  //       ),
                  //       contentPadding: EdgeInsets.symmetric(
                  //           vertical: 100.0,
                  //           horizontal: 100), // Adjust the padding
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 58,
                      
                      width: 300,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextButton(
                        onPressed: () {
                          RatingApi().userRate(
                          context: context, // Replace with actual movie name
                          rating: rating,

                          onSuccess: handleRatingSuccess,

                        );
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
              ),
                    if (ratingSubmitted)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'You rated your Driver',
                    style: GoogleFonts.lato(fontSize: 14, color: kPrimaryColor),
                  ),
                ),
                    ],
                      ),
                      
                    ),
                  ),
                );
  }
}