import 'package:cloud_firestore/cloud_firestore.dart';

class DbService {
  static DbService instance = DbService();

  late FirebaseFirestore _db;

  DbService() {
    _db = FirebaseFirestore.instance;
  }

  final String _userCollection = "Users";

  Future<void> createUserInfo(
      String uid, String name, String email, String imageUrl) async {
        try{
return await _db.collection(_userCollection).doc(uid).set({
      "name": name,
      "email": email,
      "image": imageUrl,
      "lastSeen": DateTime.now().toUtc()
    });
        }catch(e) {
          print(e);
        }
  }
}
