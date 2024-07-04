import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mute_motion_passenger/features/chat/model/messages.dart';

/* class ChatController extends GetxController{
     var chatMessages = <Message>[].obs;
} */
class ChatController extends GetxController {
  RxList<Message> chatMessages = <Message>[].obs;

  void addMessage(Message message) {
    chatMessages.add(message);
  }

  Future<void> fetchChatHistory(String senderId, String receiverId) async {
    final response = await http.get(Uri.parse('https://mutemotion.onrender.com/chat-history?senderId=$senderId&receiverId=$receiverId'));

    if (response.statusCode == 200) {
      List<dynamic> messagesJson = json.decode(response.body);
      for (var messageJson in messagesJson) {
        chatMessages.add(Message.fromJson(messageJson));
      }
    } else {
      throw Exception('Failed to load chat history');
    }
  }
}