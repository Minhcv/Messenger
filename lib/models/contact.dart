import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  String id;
  String email;
  String image;
  Timestamp lastseen;
  String name;

  Contact(
      {required this.id,
      required this.email,
      required this.name,
      required this.image,
      required this.lastseen});

  factory Contact.fromFirestore(DocumentSnapshot _snapshot) {
    Map<String, dynamic>? data = _snapshot.data as Map<String, dynamic>?;
    return Contact(
      id: _snapshot.id,
      lastseen: data!["lastSeen"],
      email: data["email"],
      name: data["name"],
      image: data["image"],
    );
  }
}
