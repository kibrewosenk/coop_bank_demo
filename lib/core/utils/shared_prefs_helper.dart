// lib/core/utils/shared_prefs_helper.dart
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const _kOnboardingStep = 'onboarding_step';
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveOnboardingStep(String step) async {
    await _prefs.setString(_kOnboardingStep, step);
  }

  static String? getOnboardingStep() {
    return _prefs.getString(_kOnboardingStep);
  }

  static Future<void> clearAll() async {
    await _prefs.clear();
  }

  // Added general methods for getting/setting strings
  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  // Optionally add more general methods if needed (e.g., for bool, int)
  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }
}