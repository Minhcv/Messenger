import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType {
  // ignore: constant_identifier_names
  Text,
  Image,
}

class Message {
  String senderID;
  String content;
  Timestamp timestamp;
  MessageType type;

  Message(
      {required this.senderID,
      required this.content,
      required this.timestamp,
      required this.type});
}
