import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mute_motion_passenger/features/chat/controller/chat_controller.dart';
import 'package:mute_motion_passenger/features/chat/model/messages.dart';
import 'package:mute_motion_passenger/features/chat/presentation/views/widgets/message_item.dart';
import 'package:mute_motion_passenger/features/translator/presentation/views/translator_view.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TextToSignBody extends StatefulWidget {
  const TextToSignBody({super.key});

  @override
  State<TextToSignBody> createState() => _TextToSignBodyState();
}

class _TextToSignBodyState extends State<TextToSignBody> {
  String ip = '';
   http.Client client = http.Client();
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  String? record;
  TextEditingController msgController = TextEditingController();
  TextEditingController ipController = TextEditingController();
  ChatController chatController = ChatController();
  var formKey = GlobalKey<FormState>();
  late IO.Socket socket;
  String Time = '';
  Timer? _timer;
  List<String> receivedMessages = [];
   void _fetchLabels() async {
    try {
      final response = await client.get(Uri.parse('http://$ip:5000/labels'));
      if (response.statusCode == 200) {
        final labels = json.decode(response.body) as Map<String, dynamic>;
        final String newMessage = labels['gesture'] ?? 'None';
        if (newMessage != 'None' && (receivedMessages.isEmpty || receivedMessages.last != newMessage)) {
          setState(() {
             receivedMessages.add(newMessage);
             var messageJson = {"message": newMessage, "sentByMe": '2'};
          chatController.chatMessages.add(Message.fromJson(messageJson));
           
          });
        }
      } else {
        print('Failed to fetch labels: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching labels: $e');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    /* socket = IO.io(
        'https://mutemotion.onrender.com/',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
    setUpSocketListener(); */
    super.initState();
    _initSpeech();
     _timer = Timer.periodic(Duration(seconds: 5), (Timer t) => _fetchLabels());
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }


  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
    );
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      sendMessage(record!);
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
     _timer?.cancel();
    client.close();
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      record = _lastWords;
      //print(record);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            iconSize: 30.sp,
            onPressed: () {
              navigateTo(context, TranslatorView());
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kPrimaryColor,
            )),
        title: Text(
          'Driver',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            color: kPrimaryColor,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        backgroundColor: Colors.transparent,
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
      body: Padding(
        padding:  EdgeInsets.only(bottom: 160.h),
        child: Obx(
          () => ListView.builder(
              itemCount: chatController.chatMessages.length,
              itemBuilder: (context, index) {
                var currentItem = chatController.chatMessages[index];
                DateTime now = DateTime.now();
                String formattedTime = DateFormat('h:mm a').format(now);
                Time = formattedTime;
                print(formattedTime);
                return MessageItem(
                  sentByMe: currentItem.sentByMe == "1",
                  message: currentItem.message,
                  time: Time,
                );
              }),
        ),
      ),
      bottomSheet: Form(
        key: formKey,
        child: Container(
          color: kPrimaryColor,
          height: 160.h,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          final bool emailValid = RegExp(
                                  r'^(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.'
                                  r'(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.'
                                  r'(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.'
                                  r'(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])$')
                              .hasMatch(value!);
                          if (value!.isEmpty) {
                            return "IP can't be empty";
                          } else if (emailValid == false) {
                            return "IP format not valid";
                          }
                          return null;
                        },
                        cursorColor: kPrimaryColor,
                        controller: ipController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter IP address to connect to the server',
                          suffixIcon: IconButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ip = ipController.text;
                                   print('asasdasdas');
                                  print(ip);
                                 // ipController.text = "";
                                }
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.solidPaperPlane,
                                color: kPrimaryColor,
                              )),
                          hintStyle: GoogleFonts.comfortaa(
                            color: Colors.black.withOpacity(0.65),
                            fontSize: 12.sp,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        cursorColor: kPrimaryColor,
                        controller: msgController,
                        decoration: InputDecoration(
                          hintText: 'Message',
                          suffixIcon: IconButton(
                              onPressed: () {
                                sendMessage(msgController.text);
                                msgController.text = "";
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.solidPaperPlane,
                                color: kPrimaryColor,
                              )),
                          hintStyle: GoogleFonts.comfortaa(
                            color: Colors.black.withOpacity(0.65),
                            fontSize: 12.sp,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendMessage(String text) async {
    print('dxzxzxzx');
   // var messageJson = {"message": text, "sentByMe": socket.id};
   // socket.emit('message', messageJson);
   // chatController.chatMessages.add(Message.fromJson(messageJson));
    try {
      final response = await client.post(
        Uri.parse('http://$ip:5000/send'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'message': text}),
      );
      if (response.statusCode != 200) {
        print('Failed to send message: ${response.statusCode}');
      } else {
        setState(() {
          var messageJson = {"message": text, "sentByMe": "1"};
          chatController.chatMessages.add(Message.fromJson(messageJson));
        });
      }
    } catch (e) {
      print('Error sending message: $e');
    }
    print('sentttt');
  }

  /* void setUpSocketListener() {
    socket.on('message-receive', (data) {
      print(data);
      chatController.chatMessages.add(Message.fromJson(data));
    });
  } */
}
