
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
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
  String lat = '0.0';
  String long = '0.0';

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
        lat = location.latitude.toString();
        long = location.longitude.toString();
        markers.clear();
        markers.add(
          Marker(
            markerId: MarkerId('Selected Location'),
            position: LatLng(double.parse(lat), double.parse(long)),
          ),
        );
      });
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(double.parse(lat), double.parse(long)),
            zoom: 15.0,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Location Not Found'),
            content: Text('The entered location could not be found.'),
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
              target: LatLng(0, 0),
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
                          'Destination Name: $destinationName',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text('Latitude: $lat'),
                        SizedBox(height: 5.0),
                        Text('Longitude: $long'),
                      ],
                    ),
                    SizedBox(width: 30.0),
                    ElevatedButton(
                      onPressed: () async {
                        navigateTo(context, Requests());

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString(
                            'destinationName', destinationName);
                        await prefs.setString('lat', lat);
                        await prefs.setString('long', long);
                        print(lat);
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
