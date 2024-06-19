import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/core/styles.dart';
import 'package:mute_motion_passenger/core/utils/widgets/customtextfield.dart';
import 'package:mute_motion_passenger/features/chat/controller/chat_controller.dart';
import 'package:mute_motion_passenger/features/chat/model/messages.dart';
import 'package:mute_motion_passenger/features/chat/presentation/views/widgets/message_item.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'chat_Item.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreenViewBody extends StatefulWidget {
  ChatScreenViewBody({super.key});

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

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
     
    );
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
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
            iconSize: 30,
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kPrimaryColor,
            )),
        title: Text(
          'Driver',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            color: kPrimaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        backgroundColor: Colors.white,
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
      body: Obx(
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
      bottomSheet: Container(
        color: kPrimaryColor,
        height: 160,
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
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: TextButton(
                          onPressed: () {
                            sendMessage('Hello');
                          },
                          child: Text(
                            'Hello',
                            overflow: TextOverflow.ellipsis,
                            style: Styles.textStyle12,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 40,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: TextButton(
                          onPressed: () {
                            sendMessage('Where are you?');
                          },
                          child: Text(
                            'Where are you?',
                            overflow: TextOverflow.ellipsis,
                            style: Styles.textStyle12,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 40,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: TextButton(
                          onPressed: () {
                            sendMessage('Don\'t be late. I\'m waiting for you!');
                          },
                          child: Text(
                            'Don\'t be late. I\'m waiting for you!',
                            overflow: TextOverflow.ellipsis,
                            style: Styles.textStyle12,
                          ),
                        ),
                      ), //
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 40,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: TextButton(
                          onPressed: () {
                            sendMessage('I\'m coming');
                          },
                          child: Text(
                            'I\'m coming',
                            overflow: TextOverflow.ellipsis,
                            style: Styles.textStyle12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
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
                          fontSize: 12,
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
            ],
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
