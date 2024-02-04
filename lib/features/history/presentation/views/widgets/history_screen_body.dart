import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/history/presentation/views/widgets/newmsg.dart';
import 'package:mute_motion_passenger/features/history/presentation/views/widgets/newmssg.dart';
import 'package:mute_motion_passenger/features/navdrawer/presentation/views/nav_drawer_view.dart';

class HistoryScreenBody extends StatelessWidget {
  const HistoryScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    int num = 1;

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
        padding: const EdgeInsets.only(
          top: 20,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              newmsg(
                req: 'Transport Request',
                driverName: 'Hassan Mahmoud',
                rate: "4.8",
                psg_loc: 'Elfath Street-Nasr City-Cairo',
                destination: 'Salah Eldeen Street-Elzamalek',
                datee: '9:20 - 25 April',
                Cost: '120',
              ),
              newmsg(
                req: 'Transport Request',
                driverName: 'Hassan Mahmoud',
                rate: "4.8",
                psg_loc: 'Elfath Street-Nasr City-Cairo',
                destination: 'Salah Eldeen Street-Elzamalek',
                datee: '9:20 - 25 April',
                Cost: '120',
              ),
              newmssg(
                req: 'City to City Request',
                driverName: 'Ahmed Essam',
                rate: "4.6",
                psg_loc: 'Elfath Street-Nasr City-Cairo',
                destination: 'Salah Eldeen Street-Elzamalek',
                datee: '9:20 - 25 April',
                Cost: '120',
                no_bags: '4',
                no_pass: '8',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
