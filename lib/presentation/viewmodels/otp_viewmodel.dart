import 'package:flutter/material.dart';
import '../../data/services/otp_service.dart';

class OtpViewModel extends ChangeNotifier {
  final OtpService _otpService = OtpService();

  Future<String> generateOtp(String identifier) => _otpService.generateOtp(identifier);

  Future<bool> validateOtp(String identifier, String otp) => _otpService.validateOtp(identifier, otp);
}