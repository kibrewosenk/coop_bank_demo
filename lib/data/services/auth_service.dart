// Updated lib/data/services/auth_service.dart (real biometric)
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart'; // Import local_auth
import '../dummy_data/users.dart';
import '../models/user_model.dart';

class AuthService {
  final _storage = const FlutterSecureStorage();
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> checkUserExists(String phone) async {
    return dummyUsers.any((user) => user.phone == phone);
  }

  Future<bool> validatePin(String phone, String pin) async {
    final user = dummyUsers.firstWhere((u) => u.phone == phone, orElse: () => UserModel(fullname:'',phone: '', nid: '', pin: '', motherName: ''));
    return user.pin == pin; // In real, hash
  }

  Future<void> savePin(String pin) async {
    await _storage.write(key: 'user_pin', value: pin);
  }

  Future<bool> registerUser(UserModel user) async {
    dummyUsers.add(user);
    return true;
  }

  Future<bool> checkBiometric() async {
    final canCheck = await _localAuth.canCheckBiometrics;
    if (!canCheck) return false;
    return await _localAuth.authenticate(localizedReason: 'Authenticate to enable biometric');
  }

  Future<bool> authenticateWithBiometric() async {
    return await _localAuth.authenticate(localizedReason: 'Login with biometric');
  }
}