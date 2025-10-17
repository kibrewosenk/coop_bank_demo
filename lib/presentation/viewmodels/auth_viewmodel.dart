import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../../data/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  String? phone; // Added to store phone across flows

  Future<bool> checkUserExists(String phone) {
    this.phone = phone;
    return _authService.checkUserExists(phone);
  }

  Future<bool> validatePin(String pin) => _authService.validatePin(phone ?? '', pin);

  Future<void> savePin(String pin) => _authService.savePin(pin);

  Future<bool> registerUser(UserModel user) => _authService.registerUser(user);

  Future<bool> checkBiometric() => _authService.checkBiometric();

  Future<bool> authenticateWithBiometric() => _authService.authenticateWithBiometric();
}