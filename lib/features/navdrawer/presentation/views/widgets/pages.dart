import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class pages extends StatelessWidget {
  const pages({
    super.key,
    required this.darkGreen,
    required this.pagename,
    required this.icone,
    required this.onpressed,
  });

  final Color darkGreen;
  final String pagename;
  final IconData icone;
  final Function() onpressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icone,
        size: 25.sp,
        color: darkGreen,
      ),
      trailing: IconButton(
        onPressed: onpressed,
        icon: Icon(
          Icons.play_arrow_rounded,
          size: 20.sp,
          color: darkGreen,
        ),
      ),
      title: Text(
        pagename,
        style: TextStyle(
          fontSize: 15.sp,
          color: darkGreen,
        ),
      ),
    );
  }
}
