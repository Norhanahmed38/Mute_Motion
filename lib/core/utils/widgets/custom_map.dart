import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mute_motion_passenger/core/utils/models/place_model.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({super.key});

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  late CameraPosition initialCameraPosition;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
        zoom: 12, target: LatLng(30.004559689941523, 30.905497794176668));
    initMarkers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    googleMapController.dispose();
  }

  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(
          //   cameraTargetBounds: CameraTargetBounds(LatLngBounds(southwest: LatLng(29.89258701483248, 30.894120378403294),northeast: LatLng(30.102087952289995, 30.97231339263223))),

          markers: markers,
          onMapCreated: (controller) {
            googleMapController = controller;
            initMapStyle();
          },
          initialCameraPosition: initialCameraPosition),
      Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: ElevatedButton(
              onPressed: () {
                CameraPosition newLocation = const CameraPosition(
                    target: LatLng(30.58873908169958, 31.488117497719035),
                    zoom: 12);
                googleMapController
                    .animateCamera(CameraUpdate.newCameraPosition(newLocation));
              },
              child: const Text('change location')))
    ]);
  }

  void initMapStyle() async {
    var roadColor = await DefaultAssetBundle.of(context)
        .loadString('lib/core/utils/map_style/road_color_gray.json');
    googleMapController.setMapStyle(roadColor);
  }

  void initMarkers() {
    var MyMarker = places
        .map((PlaceModel) => Marker(
            position: PlaceModel.latLng,
            markerId: MarkerId(PlaceModel.id.toString())))
        .toSet();
    markers.addAll(MyMarker);
  }
}
