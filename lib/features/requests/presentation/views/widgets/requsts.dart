import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/core/utils/widgets/custom_map.dart';
import 'package:mute_motion_passenger/core/utils/widgets/destmap.dart';
import 'package:mute_motion_passenger/features/navdrawer/presentation/views/nav_drawer_view.dart';
import 'package:mute_motion_passenger/features/requests/data/transprt_api.dart';
import 'package:mute_motion_passenger/features/requests/presentation/custonservice.dart';
import 'package:mute_motion_passenger/features/requests/presentation/views/requests_view.dart';
import 'package:mute_motion_passenger/features/requests/presentation/views/widgets/c_request_view.dart';
import 'package:mute_motion_passenger/features/requests/presentation/views/widgets/custom_drop_downn.dart';
import 'package:mute_motion_passenger/features/requests/presentation/views/widgets/stack.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

var locationController = TextEditingController();
var destinationnController = TextEditingController();

class _RequestsState extends State<Requests> {
  String selectedDropdownValue = "VISA";
  String serviceType = "economic";
  String latitude = "0.0";
  String longitude = "0.0";
  String lat = "0.0";
  String long = "0.0";
  bool btnPressed = false;

  static var formKey = GlobalKey<FormState>();
  var costController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    bool _isLoading = false;

    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        drawer: NavDrawerView(),
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Requests',
            style: TextStyle(
                fontSize: 24, fontFamily: 'Lato', color: Colors.white),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: 20,
            left: 15,
            right: 15,
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    'Choose which service you want',
                    style: TextStyle(
                        fontSize: 20, fontFamily: 'Lato', color: kPrimaryColor),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: stack_model(
                                color: kPrimaryColor,
                                top: -20,
                                hight: 55,
                                image: 'assets/images/rafiki.png',
                                type: 'Transport',
                                widdget: RequestsScreenView()),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            child: stack_model(
                                color: Color(0xff316F89),
                                top: -25,
                                hight: 50,
                                image: 'assets/images/cuate.png',
                                type: 'City to city',
                                widdget: RequestsScreenVieww()),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    indent: 20,
                    endIndent: 20,
                    color: kPrimaryColor,
                    thickness: 1,
                    height: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: locationController,
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'Please Enter your Location !!';
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () {
                          navigateTo(context, MapScreen());
                        },
                        icon: Icon(Icons.location_on),
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                      hintText: 'location',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: destinationnController,
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'Please Enter your Destination !!';
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () {
                          navigateTo(context, DestMap());
                        },
                        icon: Icon(Icons.airline_stops_rounded),
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                      hintText: 'Destination',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: costController,
                    keyboardType: TextInputType.number,
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'Please Enter your Expexted Cost !!';
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                      hintText: 'Expected Cost',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomDropDownn(
                    items: ["VISA", "CASH"],
                    onChanged: (value) {
                      setState(() {
                        selectedDropdownValue = value; // Update selected value
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomServiceTypeDropDown(
                    items: ['economic', 'comfort', 'luxury'],
                    onChanged: (String value) {
                      setState(() {
                        serviceType = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: kPrimaryColor,
                        minimumSize: const Size(350, 60),
                      ),
                      onPressed: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        latitude = prefs.getString('latitude') ?? '';
                        longitude = prefs.getString('longitude') ?? '';
                        lat = prefs.getString('lat') ?? "0.0";
                        long = prefs.getString('long') ?? "0.0";

                        setState(() {
                          btnPressed = true;
                        });
                        if (formKey.currentState!.validate()) {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String? id = prefs.getString("_id");
                          print('The id is $id');
                          setState(() {
                            _isLoading = true;
                          });
                          TransportApi().sendTransportRequest(
                            context: context,
                            costCont: costController,
                            startLon: longitude,
                            startLat: latitude,
                            destLon: long,
                            destLat: lat,
                            destCont: destinationnController,
                            locationCont: locationController,
                            paymentCont: selectedDropdownValue,
                            servType: serviceType,
                          );

                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      child: btnPressed == false
                          ? Text(
                              'Find Driver',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )
                          : Text(
                              'Waiting For a Driver',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
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
}
