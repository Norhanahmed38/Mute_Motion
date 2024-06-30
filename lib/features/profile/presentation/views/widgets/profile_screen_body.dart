import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/features/navdrawer/presentation/views/nav_drawer_view.dart';
import 'package:mute_motion_passenger/features/profile/model/model.dart';
import 'package:mute_motion_passenger/features/profile/presentation/views/widgets/icon.dart';
import 'package:mute_motion_passenger/features/profile/presentation/views/widgets/info.dart';
import 'package:mute_motion_passenger/features/profile/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreenViewBody extends StatefulWidget {
  ProfileScreenViewBody({Key? key}) : super(key: key);

  @override
  State<ProfileScreenViewBody> createState() => _ProfileScreenViewBodyState();
}

class _ProfileScreenViewBodyState extends State<ProfileScreenViewBody> {
  late UserModel _userData = UserModel(
    fullName: '',
    email: '',
    phone: '',
    gender: '',
  );

  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();
  Uint8List? _selectedImageBytes;

  @override
  void initState() {
    super.initState();
    fetchDataAndImage();
  }

  Future<void> fetchDataAndImage() async {
    setState(() => _isLoading = true);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      String? userId = prefs.getString("_id"); // Assuming _id is the user's ID
      UserModel userData = await ApiService.fetchUserData(token!);
      setState(() => _userData = userData);
      await _loadImage(userId!);
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveImage(Uint8List imageBytes, String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String base64Image = base64Encode(imageBytes);
    await prefs.setString('profile_image_$userId', base64Image);
  }

  Future<void> _loadImage(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? base64Image = prefs.getString('profile_image_$userId');
    setState(() {
      _selectedImageBytes =
          base64Image != null ? base64Decode(base64Image) : null;
    });
  }

  Future<void> _takePhoto() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    _processPickedImage(pickedFile);
  }

  Future<void> _openGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    _processPickedImage(pickedFile);
  }

  void _processPickedImage(XFile? pickedFile) async {
    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final bytes = await imageFile.readAsBytes();
      setState(() => _selectedImageBytes = bytes);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString("_id"); // Assuming _id is the user's ID
      _saveImage(bytes, userId!);
      Navigator.of(context).pop(); // Close the Bottom Sheet
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(360, 780),
    );
    return Scaffold(
      drawer: NavDrawerView(),
      backgroundColor: Color(0xff003248),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 60.h),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 55.h),
                      Stack(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            width: 320.w,
                            height: 75.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16.h, left: 25.w),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '100',
                                        style: TextStyle(
                                          fontFamily: 'Comfortaa',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        ' Count of Req.',
                                        style: TextStyle(
                                          fontFamily: 'Comfortaa',
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 50.w),
                                  VerticalDivider(
                                    color: Colors.white,
                                    thickness: 2,
                                    endIndent: 0,
                                    indent: 20,
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        ' EGP 2500',
                                        style: TextStyle(
                                          fontFamily: 'Comfortaa',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        ' Cost of Rides',
                                        style: TextStyle(
                                          fontFamily: 'Comfortaa',
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Info(title: 'Name', subTitle: _userData.fullName),
                      Divider(
                          indent: 5, endIndent: 5, thickness: 0.5, height: 2),
                      Info(title: 'Email', subTitle: _userData.email),
                      Divider(
                          indent: 5, endIndent: 5, thickness: 0.5, height: 2),
                      Info(title: 'Phone', subTitle: _userData.phone),
                      Divider(
                          indent: 5, endIndent: 5, thickness: 0.5, height: 2),
                      Info(title: 'Gender', subTitle: _userData.gender),
                      Divider(
                          indent: 5, endIndent: 5, thickness: 0.5, height: 2),
                    ],
                  ),
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircleAvatar(
                      radius: 70.r,
                      backgroundColor: Colors.white,
                      backgroundImage: _selectedImageBytes != null
                          ? MemoryImage(_selectedImageBytes!)
                          : AssetImage('assets/images/pic.PNG')
                              as ImageProvider<Object>?,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        CircleAvatar(
                          radius: 15.r,
                          backgroundColor: kPrimaryColor,
                        ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.r),
                                  topRight: Radius.circular(20.r),
                                ),
                              ),
                              isScrollControlled: true,
                              context: context,
                              builder: ((builder) => BottomSheetContent(
                                    takePhoto: _takePhoto,
                                    openGallery: _openGallery,
                                  )),
                            );
                          },
                          icon: Icon(
                            Icons.camera,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

class BottomSheetContent extends StatelessWidget {
  final VoidCallback takePhoto;
  final VoidCallback openGallery;

  const BottomSheetContent({
    required this.takePhoto,
    required this.openGallery,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.photo_camera),
            title: Text('Take Photo'),
            onTap: takePhoto,
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Open Gallery'),
            onTap: openGallery,
          ),
        ],
      ),
    );
  }
}
