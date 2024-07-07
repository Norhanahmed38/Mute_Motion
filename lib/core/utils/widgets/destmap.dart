import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mute_motion_passenger/features/mainMenu/presentation/views/mainMenu_screen_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/requests/presentation/views/widgets/requsts.dart';

class DestMap extends StatefulWidget {
  @override
  _DestMapState createState() => _DestMapState();
}

class _DestMapState extends State<DestMap> {
  GoogleMapController? mapController;
  TextEditingController searchController = TextEditingController();
  Set<Marker> markers = Set<Marker>();
  String destinationName = '';
  double lat = 0.0;
  double long = 0.0;

  @override
  void initState() {
    super.initState();
    // تحديد موقع مستشفى الزقازيق الجامعي
    final initialLatitude = 30.5965;
    final initialLongitude = 31.4894;

    // إضافة marker لموقع مستشفى الزقازيق الجامعي
    markers.add(
      Marker(
        markerId: MarkerId('Zagazig University Hospital'),
        position: LatLng(initialLatitude, initialLongitude),
      ),
    );

    // تحديث الحالة الأولية للخريطة
    setState(() {
      lat = initialLatitude;
      long = initialLongitude;
      destinationName = '';
    });
  }

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
        destinationName = searchController.text;
        lat = location.latitude!;
        long = location.longitude!;
        markers.clear();
        markers.add(
          Marker(
            markerId: MarkerId('Selected Location'),
            position: LatLng(lat, long),
          ),
        );
      });
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(lat, long),
            zoom: 15.0,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Location Not Found'),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(lat, long),
              zoom: 10.0,
            ),
            markers: markers,
          ),
          Positioned(
            top: 10.0,
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
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dest Name: $destinationName',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10.0),
                    ElevatedButton(
                      onPressed: () async {
                        navigateto(context, const MainMenuScreenView());

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString(
                            'destinationName', destinationName);
                        await prefs.setDouble('lat', lat);
                        await prefs.setDouble('long', long);
                        destinationnController.text = destinationName;
                      },
                      child: Text('ok'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
