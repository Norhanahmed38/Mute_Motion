import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/profile/presentation/views/profile_screen_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    });

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
      height: 150.h,
      width: 380.w,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 35.r,
                  backgroundImage: _userImageBytes != null
                      ? MemoryImage(_userImageBytes!)
                      : AssetImage('assets/images/pic.PNG') as ImageProvider,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 65.h, left: 50.w),
                    child: Text(
                      userName.isNotEmpty ? userName : 'USER',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10.w,
              ),
              Padding(
                padding: EdgeInsets.only(top: 35.h, left: 10.w),
                child: IconButton(
                  onPressed: () {
                    navigateTo(context, ProfileScreenView());
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18.sp,
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
