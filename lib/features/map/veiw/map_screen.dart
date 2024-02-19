
import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/core/utils/widgets/custom_map.dart';
class MapScreen extends StatelessWidget{
const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
home: CustomMap(),
    );
  }}
