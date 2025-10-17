import 'dart:io';
import 'package:flutter/material.dart';
import '../../data/services/camera_service.dart';

class CameraViewModel extends ChangeNotifier {
  final CameraService _cameraService = CameraService();

  Future<File?> captureSelfie() => _cameraService.captureSelfie();
}