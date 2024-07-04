import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/requests/presentation/views/widgets/requsts.dart';

import '../../../features/navdrawer/presentation/views/nav_drawer_view.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  TextEditingController searchController = TextEditingController();
  Set<Marker> markers = Set<Marker>();
  String locationName = '';
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  void dispose() {
    mapController!.dispose();
    super.dispose();
  }

  void searchLocation() async {
    List<Location> locations = await locationFromAddress(searchController.text);
    if (locations.isNotEmpty) {
      Location location = locations.first;
      setState(() {
        locationName = searchController.text;
        latitude = location.latitude!;
        longitude = location.longitude!;
        markers.clear();
        markers.add(
          Marker(
            markerId: MarkerId('Selected Location'),
            position: LatLng(latitude, longitude),
          ),
        );
      });
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: 15.0,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:const Text('Location Not Found'),
            content: const Text('The entered location could not be found.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // تحديد موقع جامعة الزقازيق
    final initialLatitude = 30.5877;
    final initialLongitude = 31.4814;

    // إضافة marker لموقع جامعة الزقازيق
    markers.add(
      Marker(
        markerId: MarkerId('Zagazig University'),
        position: LatLng(initialLatitude, initialLongitude),
      ),
    );
    // تحديث الحالة الأولية للخريطة
    setState(() {
      latitude = initialLatitude;
      longitude = initialLongitude;
      locationName = 'Zagazig University';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawerView(),
      appBar: AppBar(
        title: Text('Google Map'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              mapController?.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(latitude, longitude),
                    zoom: 15.0,
                  ),
                ),
              );
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(30.5877, 31.4814), // إحداثيات جامعة الزقازيق
              zoom: 15.0,
            ),
            markers: markers,
          ),
          Positioned(
            top: 0.0,
            left: 10.0,
            right: 10.0,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Location',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: searchLocation,
                  icon: Icon(Icons.search),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10.0,
            left: 10.0,
            right: 10.0,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Location Name: $locationName',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: () async {
                      navigateTo(context, Requests());
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('locationName', locationName);
                      await prefs.setDouble('latitude', latitude);
                      await prefs.setDouble('longitude', longitude);
                      locationController.text = locationName;
                    },
                    child: Text('ok'),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
