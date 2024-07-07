/* class Message {
  String message;
  String sentByMe;

  Message({required this.message, required this.sentByMe});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json["message"] ?? '', // Provide a default empty string if null
      sentByMe:
          json["sentByMe"] ?? '', // Provide a default empty string if null
    );
  }
} */
/* class Message {
  String message;
  String sentByMe;
   
   Message({required this.message, required this.sentByMe});
   factory Message.fromJson(Map<String,dynamic> json){
    return Message(message: json["message"], sentByMe: json["sentByMe"] );
   }
} */
class Message {
  final String senderId;
  final String receiverId;
  final String message;
  final String senderType;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.senderType,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      senderType: json['senderType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'senderType': senderType,
    };
  }
}
