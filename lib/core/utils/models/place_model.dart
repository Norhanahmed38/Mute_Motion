import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;
  PlaceModel({
    required this.name,
    required this.id,
    required this.latLng,
  });
}

List<PlaceModel> places = [
  PlaceModel(
      id: 1,
      name: 'friends cafe',
      latLng: const LatLng(30.020148604297287, 31.003604883802165)),
  PlaceModel(
      id: 2,
      name: 'Ripple',
      latLng: const LatLng(30.020114372031475, 31.00348251035441)),
];
