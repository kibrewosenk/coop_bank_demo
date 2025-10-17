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
}