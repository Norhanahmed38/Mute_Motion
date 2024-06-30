import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/core/styles.dart';
import 'package:mute_motion_passenger/features/chat/controller/chat_controller.dart';
import 'package:mute_motion_passenger/features/chat/model/messages.dart';
import 'package:mute_motion_passenger/features/chat/presentation/views/widgets/message_item.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'chat_Item.dart';

class ChatScreenViewBody extends StatefulWidget {
  ChatScreenViewBody({Key? key}) : super(key: key);

  @override
  State<ChatScreenViewBody> createState() => _ChatScreenViewBodyState();
}

class _ChatScreenViewBodyState extends State<ChatScreenViewBody> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  String? record;
  TextEditingController msgController = TextEditingController();
  ChatController chatController = ChatController();
  late IO.Socket socket;
  String Time = '';

  @override
  void initState() {
    super.initState();
    socket = IO.io(
      'https://mutemotion.onrender.com/',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );
    socket.connect();
    setUpSocketListener();
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

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      record = _lastWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(360, 690));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          iconSize: 30.w,
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kPrimaryColor,
          ),
        ),
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
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        backgroundColor: Colors.transparent,
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 160.h),
        child: Obx(
          () => ListView.builder(
            itemCount: chatController.chatMessages.length,
            itemBuilder: (context, index) {
              var currentItem = chatController.chatMessages[index];
              DateTime now = DateTime.now();
              String formattedTime = DateFormat('h:mm a').format(now);
              Time = formattedTime;
              return MessageItem(
                sentByMe: currentItem.sentByMe == socket.id,
                message: currentItem.message,
                time: Time,
              );
            },
          ),
        ),
      ),
      bottomSheet: Container(
        color: kPrimaryColor,
        height: 160.h,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Row(
                    children: [
                      ChatItem(
                        text: 'Hello',
                        onPressed: () {
                          sendMessage('Hello');
                        },
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      ChatItem(
                        text: 'Where are you?',
                        onPressed: () {
                          sendMessage('Where are you?');
                        },
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      ChatItem(
                        text: 'Don\'t be late. I\'m waiting for you!',
                        onPressed: () {
                          sendMessage('Don\'t be late. I\'m waiting for you!');
                        },
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      ChatItem(
                        text: 'I\'m coming',
                        onPressed: () {
                          sendMessage('I\'m coming');
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.w),
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
                          msgController.text = '';
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.solidPaperPlane,
                          color: kPrimaryColor,
                        ),
                      ),
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
            ],
          ),
        ),
      ),
    );
  }

  void sendMessage(String text) {
    var messageJson = {"message": text, "sentByMe": socket.id};
    socket.emit('message', messageJson);
    chatController.chatMessages.add(Message.fromJson(messageJson));
  }

  void setUpSocketListener() {
    socket.on('message-receive', (data) {
      chatController.chatMessages.add(Message.fromJson(data));
    });
  }
}
