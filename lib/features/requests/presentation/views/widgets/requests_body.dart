import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/navdrawer/presentation/views/nav_drawer_view.dart';
import 'package:intl/intl.dart';
import 'package:mute_motion_passenger/features/requests/presentation/custonservice.dart';
import 'package:mute_motion_passenger/features/requests/presentation/views/requests_view.dart';
import 'package:mute_motion_passenger/features/requests/presentation/views/widgets/c_request_view.dart';
import 'package:mute_motion_passenger/features/requests/presentation/views/widgets/custom_drop_downn.dart';
import 'package:mute_motion_passenger/features/requests/presentation/views/widgets/stack.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestsBody extends StatefulWidget {
  const RequestsBody({super.key});

  @override
  State<RequestsBody> createState() => _RequestsBodyState();
}

class _RequestsBodyState extends State<RequestsBody> {
  bool btnPressed = false;
  String selectedDropdownValue = "VISA";
  String serviceType = "economic";

  String? dateAndtime;

  static var formKey = GlobalKey<FormState>();
  var locationController = TextEditingController();
  var destinationController = TextEditingController();
  var dateAndTimeController = TextEditingController();
  var costController = TextEditingController();
  var paymentController = TextEditingController();
  var passengersController = TextEditingController();
  var bagsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(370, 690),
    );
    final format = DateFormat("yyyy-MM-dd HH:mma");
    bool _isLoading = false;

    String dropdownvalue = 'Payment Method';

    var items = [
      'Payment Method',
      'VISA',
      'CASH',
    ];

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
                fontSize: 24.sp, fontFamily: 'Lato', color: Colors.white),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: EdgeInsets.only(
            top: 20.h,
            left: 15.w,
            right: 15.w,
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
                        fontSize: 20.sp,
                        fontFamily: 'Lato',
                        color: kPrimaryColor),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: stack_model(
                                color: Color(0xff316F89),
                                top: -20,
                                hight: 55.h,
                                image: 'assets/images/rafiki.png',
                                type: 'Transport',
                                widdget: RequestsScreenView()),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          SizedBox(
                            child: stack_model(
                                color: kPrimaryColor,
                                top: -25,
                                hight: 50.h,
                                image: 'assets/images/cuate.png',
                                type: 'City to city',
                                widdget: RequestsScreenVieww()),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(
                    indent: 20.w,
                    endIndent: 20.w,
                    color: kPrimaryColor,
                    thickness: 1.h,
                    height: 2.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    controller: locationController,
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'Please Enter your Location !!';
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                      hintText: 'location',
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    controller: destinationController,
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'Please Enter your Destination !!';
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.airline_stops_rounded,
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                      hintText: 'Destination',
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
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
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                      hintText: 'Expected Cost',
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    controller: passengersController,
                    keyboardType: TextInputType.number,
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'Please Enter No of Passenger !!';
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                      hintText: 'No of Passenger',
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    controller: bagsController,
                    keyboardType: TextInputType.number,
                    validator: (data) {
                      if (data!.isEmpty) {
                        return 'Please Enter No of Passenger !!';
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                      hintText: 'No of bags',
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
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
                    height: 10.h,
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
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        minimumSize: Size(350.w, 60.h),
                        backgroundColor: kPrimaryColor,
                      ),
                      onPressed: () async {
                        setState(() {
                          btnPressed = true;
                        });
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          print(locationController.text);
                          print(destinationController.text);

                          print(passengersController.text);

                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      child: btnPressed == false
                          ? Text(
                              'Find Driver',
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.white),
                            )
                          : Text(
                              'Waiting For A Driver',
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.white),
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

void _showErrorDialog(
  BuildContext context,
  String message,
  TextEditingController destination,
  TextEditingController location,
  TextEditingController bags,
  TextEditingController cost,
  TextEditingController date,
  TextEditingController passenger,
  TextEditingController payment,
  TextEditingController time,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0.r),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20.sp, fontFamily: 'Comfortaa', color: kPrimaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () {
              bags.clear();
              passenger.clear();
              date.clear();
              payment.clear();
              destination.clear();
              location.clear();
              cost.clear();
              time.clear();
              Navigator.of(context).pop();
            },
            child: Container(
              width: 120.w,
              height: 45.h,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(20.0.r),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Text(
                  'Try Again',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: 'Comfortaa',
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
