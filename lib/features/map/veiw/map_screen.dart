import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/core/utils/widgets/custom_map.dart';
import 'package:mute_motion_passenger/features/map2/screen/map.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: map(),
    );
  }
}
