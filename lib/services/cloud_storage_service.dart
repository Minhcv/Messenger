import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageService {
  static CloudStorageService instance = CloudStorageService();

  late FirebaseStorage _storage;
  late Reference _baseRef;

  final String _profileImages = "profileImages";

  CloudStorageService() {
    _storage = FirebaseStorage.instance;
    _baseRef = _storage.ref();
  }

  Future<TaskSnapshot?> uploadImage(String uid, File image) async {
    try {
      return await _baseRef
          .child(_profileImages)
          .child(uid)
          .putFile(image)
          .whenComplete(() {});
    } catch (e) {
      print(e);
    }
  }
}
