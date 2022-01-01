class MessageModel {
  late String dateTime;
  late String senderId;
  late String receiverId;
  late String text;


  MessageModel({
    required this.dateTime,
    required this.senderId,
    required this.receiverId,
    required this.text,

  });

  MessageModel.fromJson(Map<String, dynamic>? json) {
    text = json!['text'];
    dateTime = json['dateTime'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];

  }

  Map<String, dynamic> toJson() {
    return {
      'dateTime': dateTime,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,

    };
  }
}
