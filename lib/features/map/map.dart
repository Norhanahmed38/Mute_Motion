import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/Rating/presentation/views/rating_view.dart';
import 'package:mute_motion_passenger/features/chat/presentation/views/chat_screen_view.dart';

class MapScreenn extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreenn> {
  GoogleMapController? _controller;

  static final LatLng alMabaraHospital = LatLng(30.5752, 31.4513);
  static final LatLng zagazigUniversity = LatLng(30.5877, 31.4823);
  static final LatLng alAhrarHospital = LatLng(30.5885, 31.4904);

  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId('AlMabaraHospital'),
      position: alMabaraHospital,
      infoWindow: InfoWindow(title: 'مستشفى المبرة'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    ),
    Marker(
      markerId: MarkerId('AlAhrarHospital'),
      position: alAhrarHospital,
      infoWindow: InfoWindow(title: 'مستشفى الأحرار'),
      icon: BitmapDescriptor.defaultMarker,
    ),
  };

  final Set<Polyline> _polylines = {
    Polyline(
      polylineId: PolylineId('route1'),
      points: [
        alMabaraHospital,
        zagazigUniversity,
      ],
      color: Colors.green,
      width: 5,
    ),
    Polyline(
      polylineId: PolylineId('route2'),
      points: [
        zagazigUniversity,
        alAhrarHospital,
      ],
      color: Colors.red,
      width: 5,
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Tracking'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              setState(() {
                _controller = controller;
              });
            },
            initialCameraPosition: CameraPosition(
              target: zagazigUniversity,
              zoom: 14,
            ),
            markers: _markers,
            polylines: _polylines,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              color: kPrimaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Column(
                    children: [
                      SizedBox(height: 9),
                      Text(
                        'Driver is arriving in: 3 min',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 9),
                      Text(
                        'Trip Duration: 15 min',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateTo(context, ChatScreenView());
                    },
                    child: Icon(Icons.chat, size: 40, color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateTo(context, RatingViewScreen());
                    },
                    child: Icon(Icons.feedback, size: 40, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
