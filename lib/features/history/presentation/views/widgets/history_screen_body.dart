import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/history/presentation/views/widgets/data/history.dart';

import 'package:mute_motion_passenger/features/history/presentation/views/widgets/model/order.dart';
import 'package:mute_motion_passenger/features/history/presentation/views/widgets/newmsg.dart';
import 'package:mute_motion_passenger/features/navdrawer/presentation/views/nav_drawer_view.dart';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreenBody extends StatefulWidget {
  @override
  _HistoryScreenBodyState createState() => _HistoryScreenBodyState();
}

class _HistoryScreenBodyState extends State<HistoryScreenBody> {
  late Future<List<CompletedOrder>> futureCompletedOrders;

  @override
  void initState() {
    super.initState();
    futureCompletedOrders = fetchCompletedOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawerView(),
      backgroundColor: Color(0xff003248),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'History',
          style:
              TextStyle(fontSize: 24, fontFamily: 'Lato', color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: FutureBuilder<List<CompletedOrder>>(
          future: futureCompletedOrders,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Requests yet',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Comfortaa',
                          color: kPrimaryColor),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Start your first ride & request now!',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Comfortaa',
                          color: kPrimaryColor),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final order = snapshot.data![index];
                  return Column(
                    children: [
                      newmsg(
                        req: 'Transport Request',
                        driverName: 'Ahmed Fawzy',
                        rate: "3.2",
                        psg_loc: order.locationName,
                        destination: order.destinationName,
                        service: order.serviceType,
                        Cost: order.cost,
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
