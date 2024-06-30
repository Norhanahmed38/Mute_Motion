import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    socket = IO.io(
        'https://mutemotion.onrender.com/',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
    setUpSocketListener();
    super.initState();
    _initSpeech();
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
                  sentByMe: currentItem.sentByMe == socket.id,
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
                          hintText: 'Enter IP address',
                          suffixIcon: IconButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ip = ipController.text;
                                  print(ip);
                                  ipController.text = "";
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
                  height: 10.h,
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

  void sendMessage(String text) {
    print('dxzxzxzx');
    var messageJson = {"message": text, "sentByMe": socket.id};
    socket.emit('message', messageJson);
    chatController.chatMessages.add(Message.fromJson(messageJson));
    print('sentttt');
  }

  void setUpSocketListener() {
    socket.on('message-receive', (data) {
      print(data);
      chatController.chatMessages.add(Message.fromJson(data));
    });
  }
}
