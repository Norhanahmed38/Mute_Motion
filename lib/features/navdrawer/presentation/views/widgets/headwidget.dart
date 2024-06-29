import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/profile/presentation/views/profile_screen_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HadWidget extends StatefulWidget {
  const HadWidget({
    Key? key,
    required this.darkGreen,
  }) : super(key: key);

  final Color darkGreen;

  @override
  _HadWidgetState createState() => _HadWidgetState();
}

class _HadWidgetState extends State<HadWidget> {
  String userName = '';
  String useremail = '';
  Uint8List? _userImageBytes; // Variable to store user image bytes

  @override
  void initState() {
    super.initState();
    _getUserDataAndImage();
  }

  Future<void> _getUserDataAndImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('firstname') ?? '';
      useremail = prefs.getString('email') ?? '';
    });

    // Load user image from SharedPreferences
    await _loadUserImage();
  }

  Future<void> _loadUserImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('_id');
    String? base64Image = prefs.getString('profile_image_$userId');
    if (base64Image != null) {
      setState(() {
        _userImageBytes = base64Decode(base64Image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.darkGreen,
      height: 150,
      width: 380,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 35,
                  backgroundImage: _userImageBytes != null
                      ? MemoryImage(_userImageBytes!)
                      : AssetImage('assets/images/pic.PNG') as ImageProvider,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 55, left: 8),
                    child: Text(
                      userName.isNotEmpty ? userName : 'USER',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      useremail.isNotEmpty ? useremail : '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: EdgeInsets.only(top: 35, left: 10),
                child: IconButton(
                  onPressed: () {
                    navigateTo(context, ProfileScreenView());
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
