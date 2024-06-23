import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/Rating/presentation/views/rating_view.dart';
import 'package:mute_motion_passenger/features/mainMenu/presentation/views/mainMenu_screen_view.dart';
import 'package:mute_motion_passenger/features/requests/data/models/driver_model.dart';
import 'package:mute_motion_passenger/features/requests/data/request_api.dart';
import 'package:mute_motion_passenger/features/requests/presentation/views/widgets/requsts.dart';

class DriverProfileViewBody extends StatefulWidget {
  final DriverModel? driverModel;

  const DriverProfileViewBody({this.driverModel});

  @override
  State<DriverProfileViewBody> createState() => _DriverProfileViewBodyState();
}

class _DriverProfileViewBodyState extends State<DriverProfileViewBody> {
  @override
  Widget build(BuildContext context) {
    String displayedRating =
        double.parse(widget.driverModel?.driver?.rating ?? '0')
            .toStringAsFixed(1);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          title: Text(
            'Driver Profile',
            style: GoogleFonts.comfortaa(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 20,
              left: 7,
              right: 7,
            ),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Padding(
              padding:
                  const EdgeInsets.only(right: 5, top: 20, bottom: 20, left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Driver will be in your destination ",
                    style: GoogleFonts.comfortaa(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                  Text(
                    "After ${widget.driverModel?.estimatedTimeToArrive}mins (${widget.driverModel?.distanceToDriver})m ",
                    style: GoogleFonts.comfortaa(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff760F07),
                    ),
                  ),
                  Text(
                    "The cost of the trip will be ${widget.driverModel?.cost}EGP",
                    style: GoogleFonts.comfortaa(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/driver.png'),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    " ${widget.driverModel?.driver?.fullname}",
                    style: GoogleFonts.comfortaa(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.solidStar,
                        color: Color(0xffF7B731),
                        size: 15,
                      ),
                      Text(
                        " $displayedRating (${widget.driverModel?.driver?.numberOfReviews}Reviewers)",
                        style: GoogleFonts.comfortaa(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 5, left: 5),
                    width: double.infinity,
                    height: 110,
                    decoration: BoxDecoration(
                        color: const Color(0xff003248),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "car number: ${widget.driverModel?.driver?.carnum}",
                              style: GoogleFonts.comfortaa(
                                  fontSize: 10, color: Colors.white),
                            ),
                            Text(
                              "car color: ${widget.driverModel?.driver?.color}",
                              style: GoogleFonts.comfortaa(
                                  fontSize: 10, color: Colors.white),
                            ),
                            Text(
                              "car model: ${widget.driverModel?.driver?.model}",
                              style: GoogleFonts.comfortaa(
                                  fontSize: 10, color: Colors.white),
                            ),
                            Text(
                              "  cardescription: ${widget.driverModel?.driver?.cardescription} ",
                              style: GoogleFonts.comfortaa(
                                  fontSize: 10, color: Colors.white),
                            ),
                          ],
                        ),
                        Container(
                          child: Image.asset('assets/images/car 1.png'),
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
                        const FaIcon(FontAwesomeIcons.solidEnvelope),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          " ${widget.driverModel?.driver?.email}",
                          style: GoogleFonts.comfortaa(
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
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
                        const FaIcon(FontAwesomeIcons.phone),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          " ${widget.driverModel?.driver?.phone}",
                          style: GoogleFonts.comfortaa(
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(children: [
                      ElevatedButton(
                        child: Text("Cancel",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RatingViewScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: kPrimaryColor,
                          minimumSize: const Size(60, 60),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      ElevatedButton(
                        child: Text("confirm request",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        onPressed: () async {
                          await ApiService.sendRequest(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: kPrimaryColor,
                          minimumSize: const Size(60, 60),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
