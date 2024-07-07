import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:mute_motion_passenger/features/requests/data/models/driver_model.dart'
    as dm;

class MapProvider extends ChangeNotifier {
  dm.DriverModel driverModel = dm.DriverModel();

  getDriverModel(model) {
    driverModel = model;
    notifyListeners();
  }

  LatLng? location;
  LatLng? destination;
  String? cost;

  String? locationname;
  String? destinationname;

  getMyData({LatLng? myLocation, LatLng? myDestination, String? myCost}) {
    location = myLocation;
    destination = myDestination;
    cost = myCost;
    notifyListeners();
    addMarkers();
  }

  getlocationsname({String? myLocationname, String? myDestinationname}) {
    locationname = myLocationname;
    destinationname = myDestinationname;
  }

  LocationData? currentLocation;
  final String apiKey = 'AIzaSyCzJMVMlvGMUOEmy5Dzpy2mrbicp_gylHk';
  GoogleMapController? controller;
  Set<Polyline> polylines = {};
  Set<Marker> markers = {};

  void initState() {
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    currentLocation = await location.getLocation();
    notifyListeners();
    addMarkers();
    // Call addCustomPolyline after fetching current location
    addCustomPolyline();
  }

  Future<void> getRoute() async {
    if (currentLocation == null) return;
    String origin =
        '${currentLocation!.latitude},${currentLocation!.longitude}';
    double destinationLat = destination?.latitude ?? 0.0;
    double destinationLng = destination?.longitude ?? 0.0;

    int retryCount = 3;

    for (int attempt = 0; attempt < retryCount; attempt++) {
      try {
        print(apiKey.toString());
        final response = await http
            .post(
              Uri.parse(
                'https://routes.googleapis.com/directions/v2:computeRoutes?key=$apiKey',
              ),
              headers: {
                'Content-Type': 'application/json',
                'X-Goog-FieldMask':
                    'routes.distanceMeters,routes.duration,routes.polyline.encodedPolyline',
              },
              body: json.encode({
                'origin': {
                  'location': {
                    'latLng': {
                      'latitude': location!.latitude,
                      'longitude': location!.longitude
                    }
                  }
                },
                'destination': {
                  'location': {
                    'latLng': {
                      'latitude': destination!.latitude,
                      'longitude': destination!.longitude
                    }
                  }
                },
                'travelMode': 'DRIVE',
              }),
            )
            .timeout(
                const Duration(seconds: 30)); // Increase the timeout duration
        print(response.body.toString());
        print(response.statusCode.toString());
        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          if (data['routes'] != null && data['routes'].isNotEmpty) {
            final encodedPolyline =
                data['routes'][0]['polyline']['encodedPolyline'];
            List<LatLng> polylineCoordinates = _decodePolyline(encodedPolyline);

            polylines.add(
              Polyline(
                polylineId: PolylineId('route'),
                points: polylineCoordinates,
                color: Colors.blue,
                width: 5,
              ),
            );
            controller
                ?.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: destination!,
              zoom: 12,
            )));
            notifyListeners();
            break; // Exit loop if successful
          }
        }
      } catch (e) {
        if (attempt < retryCount - 1) {
          await Future.delayed(
              const Duration(seconds: 2)); // Wait before retrying
        }
      }
    }
  }

  void addCustomPolyline() {
    if (location != null) {
      LatLng customDestination = LatLng(30.591553117847635, 31.49370053670618);
      polylines.add(
        Polyline(
          polylineId: PolylineId('customRoute'),
          points: [location!, customDestination],
          color: Colors.red,
          width: 5,
        ),
      );
      notifyListeners();
    }
  }

  void addMarkers() {
    markers.clear();
    if (location != null) {
      markers.add(
        Marker(
          markerId: MarkerId('location'),
          position: location!,
          infoWindow: InfoWindow(title: 'Location'),
        ),
      );
    }
    if (destination != null) {
      markers.add(
        Marker(
          markerId: MarkerId('destination'),
          position: destination!,
          infoWindow: InfoWindow(title: 'Destination'),
        ),
      );
    }
    LatLng customDestination = LatLng(30.591553117847635, 31.49370053670618);
    markers.add(
      Marker(
        markerId: MarkerId('customDestination'),
        position: customDestination,
        infoWindow: InfoWindow(title: 'Custom Destination'),
      ),
    );
    notifyListeners();
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      LatLng p = LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      polyline.add(p);
    }

    return polyline;
  }
}
