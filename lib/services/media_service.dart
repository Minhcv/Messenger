import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MediaService {
  static MediaService instance = MediaService();

  final ImagePicker _imagePicker = ImagePicker();

  Future<XFile?> getImageFromLibrary() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }
}
