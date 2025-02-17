import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mute_motion_passenger/features/trip_track/provider/map_provider.dart';
import 'package:provider/provider.dart';
import 'package:mute_motion_passenger/core/utils/widgets/once_future_builder.dart';

import '../../../core/utils/widgets/containerdisplay.dart';

class RouteScreen extends StatelessWidget {
  const RouteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MapProvider>(builder: (context, provider, child) {
      return OnceFutureBuilder(
        future: ()async{
          provider.initState();
        },
        builder:(context,snapshot) => Scaffold(
          appBar: AppBar(
            title: const Text('Route Finder'),
          ),
          body: Stack(
            children: <Widget>[
              provider.currentLocation == null
                  ? const Center(child: CircularProgressIndicator())
                  : GoogleMap(
                onMapCreated: (controller) {
                  provider.controller = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(provider.currentLocation!.latitude!,
                      provider.currentLocation!.longitude!),
                  zoom: 14,
                ),
                polylines: provider.polylines,
              ),
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child:maindisplay(),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: provider.getRoute1,
            child: const Icon(Icons.directions),
          ),
        ),
      );
    });
  }
}