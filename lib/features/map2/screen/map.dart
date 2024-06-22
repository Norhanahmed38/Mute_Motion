import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mute_motion_passenger/features/navdrawer/presentation/views/widgets/nav_drawer.dart';

import '../../../core/utils/widgets/containerdisplay.dart';
import 'mapbody.dart';

class map extends StatefulWidget {
  const map({super.key});

  @override
  State<map> createState() => mapState();
}

class mapState extends State<map> {
  void initState() {
    //googleMapController;

    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  GoRouter.of(context).push('/chat');
                },
                child: CircleAvatar(
                    backgroundColor: Color(0xff003248),
                    radius: 25,
                    child: Icon(Icons.message))),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  GoRouter.of(context).push('/search');
                },
                child: CircleAvatar(
                    backgroundColor: Color(0xff003248),
                    radius: 25,
                    child: Icon(Icons.location_searching)))
          ],
        ),
        drawer: NavDrawer(),
        body: Stack(
          children: <Widget>[
            mymap(),
            Positioned(bottom: 0, child: maindisplay())
          ],
        ));
  }
}
