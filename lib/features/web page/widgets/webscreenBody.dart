import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WebpageBody extends StatefulWidget {
  const WebpageBody({super.key});

  @override
  State<WebpageBody> createState() => _WebpageBodyState();
}

class _WebpageBodyState extends State<WebpageBody> {
   
   final String url = 'https://www.google.com';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
  }
  Future<void> _launchUrl() async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
        print('Launched URL: $url');
      } else {
        print('Could not launch $url');
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('WebView Example'),
      ),
      body:  Center(
            child: ElevatedButton(
              onPressed: _launchUrl,
              child: Text('Show Flutter homepage'),
            ),
          ),
    );
  }
}