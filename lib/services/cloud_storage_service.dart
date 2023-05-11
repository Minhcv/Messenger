import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class CloudStorageService {
  static CloudStorageService instance = CloudStorageService();

  late FirebaseStorage _storage;
  late Reference _baseRef;

  final String _profileImages = "profileImages";
  final String _messages = "messages";
  final String _images = "images";

  CloudStorageService() {
    _storage = FirebaseStorage.instance;
    _baseRef = _storage.ref();
  }

  Future<TaskSnapshot?> uploadUserImage(String uid, File image) async {
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

  Future<TaskSnapshot>? uploadMediaMessage(String _uid, File _file) {
    var _timestamp = DateTime.now();
    var _fileName = path.basename(_file.path);
    _fileName += "_${_timestamp.toString()}";
    try {
      return _baseRef
          .child(_messages)
          .child(_uid)
          .child(_images)
          .child(_fileName)
          .putFile(_file)
          .whenComplete(() {});
    } catch (e) {
      print(e);
      return null;
    }
  }
}
