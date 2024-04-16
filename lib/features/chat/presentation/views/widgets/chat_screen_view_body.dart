import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mute_motion_passenger/constants.dart';
import 'package:mute_motion_passenger/core/styles.dart';
import 'package:mute_motion_passenger/core/utils/widgets/customtextfield.dart';
import 'package:mute_motion_passenger/features/chat/presentation/views/widgets/message_item.dart';

import 'chat_Item.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreenViewBody extends StatefulWidget {
  ChatScreenViewBody({super.key});

  @override
  State<ChatScreenViewBody> createState() => _ChatScreenViewBodyState();
}

class _ChatScreenViewBodyState extends State<ChatScreenViewBody> {
  TextEditingController msgController = TextEditingController();

  late IO.Socket socket;
  @override
  void initState() {
    // TODO: implement initState
    socket = IO.io(
        'http://localhost:4000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
    super.initState();
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
      body: Container(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return MessageItem(
                sentByMe: true,
              );
            }),
      ),
      bottomSheet: Container(
        color: kPrimaryColor,
        height: 160,
        width: double.infinity,
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
                  children: const [
                    chatItem(text: 'Hello'),
                    SizedBox(
                      width: 5,
                    ),
                    chatItem(text: 'Where are you'),
                    SizedBox(
                      width: 5,
                    ),
                    chatItem(text: "Don't be late, I'm waiting for you"),
                    SizedBox(
                      width: 5,
                    ),
                    chatItem(text: 'I\'m coming'),
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
                            var messageJson = {
                              "message": msgController.text,
                              "sentByMe": socket.id
                            };
                            socket.emit('message', messageJson);
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
    );
  }

  void sendMessage(String text) {
    print('dxzxzxzx');
    var messageJson = {"message": text, "sentByMe": socket.id};
    socket.emit('message', messageJson);
    print('dxzxzxzx');
  }
}
