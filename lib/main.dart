import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:mute_motion_passenger/core/utils/widgets/custom_map.dart';
import 'package:mute_motion_passenger/features/chat/presentation/views/chat_screen_view.dart';
import 'package:mute_motion_passenger/features/chat/presentation/views/widgets/chat_screen_view_body.dart';
import 'package:mute_motion_passenger/features/driverProfile/presentation/views/DriverProfileView.dart';
import 'package:mute_motion_passenger/features/driverProfile/presentation/views/widgets/driver_profile_view_body.dart';
import 'package:mute_motion_passenger/features/mainMenu/presentation/views/mainMenu_screen_view.dart';
import 'package:mute_motion_passenger/features/map/veiw/map_screen.dart';
import 'package:mute_motion_passenger/features/map2/screen/map.dart';
import 'package:mute_motion_passenger/features/profile/presentation/views/profile_screen_view.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/OTP_screen_view.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/create_Profile_screen.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/login_screen_view.dart';
import 'package:mute_motion_passenger/features/registration/presentation/views/widgets/forget_pass.dart';
import 'package:mute_motion_passenger/features/requests/presentation/views/widgets/c_request_view.dart';
import 'package:mute_motion_passenger/features/requests/presentation/views/widgets/requsts.dart';
import 'package:mute_motion_passenger/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/services.dart';
import 'package:mute_motion_passenger/features/translator/presentation/views/Text_to_sign.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreenView(),
    );
  }
}
