class TranslatorMessage {
  String message;
  String sentByMe;

  TranslatorMessage({required this.message, required this.sentByMe});

  factory TranslatorMessage.fromJson(Map<String, dynamic> json) {
    return TranslatorMessage(
      message: json["message"] ?? '', // Provide a default empty string if null
      sentByMe:
          json["sentByMe"] ?? '', // Provide a default empty string if null
    );
  }
}