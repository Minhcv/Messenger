import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message.dart';

class ConversationSnippet {
  String id;
  String conversationID;
  String lastMessage;
  String name;
  String image;
  MessageType type;
  int unseenCount;
  Timestamp timestamp;

  ConversationSnippet(
      {required this.conversationID,
      required this.id,
      required this.lastMessage,
      required this.unseenCount,
      required this.timestamp,
      required this.name,
      required this.image,
      required this.type});

  factory ConversationSnippet.fromFirestore(DocumentSnapshot _snapshot) {
    Map<String, dynamic>? data = _snapshot.data as Map<String, dynamic>?;
    var messageType = MessageType.Text;
    if (data!["type"] != null) {
      switch (data["type"]) {
        case "text":
          break;
        case "image":
          messageType = MessageType.Image;
          break;
        default:
      }
    }
    return ConversationSnippet(
      id: _snapshot.id,
      conversationID: data["conversationID"],
      lastMessage: data["lastMessage"] ?? "",
      unseenCount: data["unseenCount"],
      timestamp: data["timestamp"],
      name: data["name"],
      image: data["image"],
      type: messageType,
    );
  }
}

class Conversation {
  String id;
  List members;
  List<Message> messages;
  String ownerID;

  Conversation(
      {required this.id,
      required this.members,
      required this.ownerID,
      required this.messages});

  factory Conversation.fromFirestore(DocumentSnapshot _snapshot) {
    Map<String, dynamic>? data = _snapshot.data as Map<String, dynamic>?;
    List messages = data!["messages"];
    if (messages != null) {
      messages = messages.map(
        (_m) {
          return Message(
              type: _m["type"] == "text" ? MessageType.Text : MessageType.Image,
              content: _m["message"],
              timestamp: _m["timestamp"],
              senderID: _m["senderID"]);
        },
      ).toList();
    } else {
      messages = [];
    }

    List<Message> messageList =
        messages.map((item) => item as Message).toList();
    return Conversation(
        id: _snapshot.id,
        members: data["members"],
        ownerID: data["ownerID"],
        messages: messageList);
  }
}
