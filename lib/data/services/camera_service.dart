import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CameraService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> captureSelfie() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    return photo != null ? File(photo.path) : null;
  }
}