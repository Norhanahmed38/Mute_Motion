import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:mute_motion_passenger/features/requests/data/models/driver_model.dart' as dm;

class MapProvider extends ChangeNotifier {
  dm.DriverModel driverModel = dm.DriverModel();

  void getDriverModel(dm.DriverModel model) {
    driverModel = model;
    notifyListeners();
  }

  LatLng? location;
  LatLng? destination;
  String? cost;

  void getMyData({LatLng? myLocation, LatLng? myDestination, String? myCost}) {
    location = myLocation;
    destination = myDestination;
    cost = myCost;
    notifyListeners();
  }

  LocationData? currentLocation;
  final String apiKey = 'AIzaSyCzJMVMlvGMUOEmy5Dzpy2mrbicp_gylHk';
  GoogleMapController? controller;
  Set<Polyline> polylines = {};

  void initState() {
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    Location locationService = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await locationService.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationService.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await locationService.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locationService.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    currentLocation = await locationService.getLocation();
    notifyListeners();
  }

  Future<void> getRoute() async {
    if (currentLocation == null) return;
    String origin = '${currentLocation!.latitude},${currentLocation!.longitude}';
    double destinationLat = destination?.latitude ?? 0.0;
    double destinationLng = destination?.longitude ?? 0.0;

    int retryCount = 3;

    for (int attempt = 0; attempt < retryCount; attempt++) {
      try {
        final response = await http.post(
          Uri.parse(
            'https://routes.googleapis.com/directions/v2:computeRoutes?key=$apiKey',
          ),
          headers: {
            'Content-Type': 'application/json',
            'X-Goog-FieldMask': 'routes.distanceMeters,routes.duration,routes.polyline.encodedPolyline',
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
        ).timeout(const Duration(seconds: 30)); // Increase the timeout duration
        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          if (data['routes'] != null && data['routes'].isNotEmpty) {
            final encodedPolyline = data['routes'][0]['polyline']['encodedPolyline'];
            List<LatLng> polylineCoordinates = _decodePolyline(encodedPolyline);

            polylines.add(
              Polyline(
                polylineId: PolylineId('route'),
                points: polylineCoordinates,
                color: Colors.blue,
                width: 5,
              ),
            );
            controller?.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: destination!,
              zoom: 12,
            )));
            notifyListeners();
            break; // Exit loop if successful
          }
        }
      } catch (e) {
        if (attempt < retryCount - 1) {
          await Future.delayed(const Duration(seconds: 2)); // Wait before retrying
        }
      }
    }
  }

  Future<void> getRoute1() async {
    if (currentLocation == null) return;

    LatLng destinationPoint = LatLng(30.58551586381342, 31.494316249703868);
    double destinationLat = destinationPoint.latitude;
    double destinationLng = destinationPoint.longitude;

    int retryCount = 3;

    for (int attempt = 0; attempt < retryCount; attempt++) {
      try {
        final response = await http.post(
          Uri.parse(
            'https://routes.googleapis.com/directions/v2:computeRoutes?key=$apiKey',
          ),
          headers: {
            'Content-Type': 'application/json',
            'X-Goog-FieldMask': 'routes.distanceMeters,routes.duration,routes.polyline.encodedPolyline',
          },
          body: json.encode({
            'origin': {
              'location': {
                'latLng': {
                  'latitude': currentLocation!.latitude,
                  'longitude': currentLocation!.longitude
                }
              }
            },
            'destination': {
              'location': {
                'latLng': {
                  'latitude': destinationLat,
                  'longitude': destinationLng
                }
              }
            },
            'travelMode': 'DRIVE',
          }),
        ).timeout(const Duration(seconds: 30)); // Increase the timeout duration
        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          if (data['routes'] != null && data['routes'].isNotEmpty) {
            final encodedPolyline = data['routes'][0]['polyline']['encodedPolyline'];
            List<LatLng> polylineCoordinates = _decodePolyline(encodedPolyline);

            polylines.add(
              Polyline(
                polylineId: PolylineId('route1'),
                points: polylineCoordinates,
                color: Colors.red,
                width: 5,
              ),
            );
            controller?.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: destinationPoint,
              zoom: 12,
            )));
            notifyListeners();
            break; // Exit loop if successful
          }
        }
      } catch (e) {
        if (attempt < retryCount - 1) {
          await Future.delayed(const Duration(seconds: 2)); // Wait before retrying
        }
      }
    }
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
