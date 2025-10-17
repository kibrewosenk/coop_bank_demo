class Validators {
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone is required';
    final phone = value.trim();
    final regex = RegExp(r'^\+?\d{9,13}$');
    if (!regex.hasMatch(phone)) return 'Enter a valid phone number';
    return null;
  }

  static String? validateNid(String? value) {
    if (value == null || value.trim().isEmpty) return 'NID is required';
    if (value.trim().length < 6) return 'Enter a valid NID';
    return null;
  }

  static String? validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) return 'OTP is required';
    if (value.trim().length != 4) return 'OTP must be 4 digits';
    return null;
  }

  static String? validatePin(String? value) {
    if (value == null || value.isEmpty) return 'PIN is required';
    if (value.length < 4) return 'PIN must be at least 4 digits';
    return null;
  }

  static String? confirmPin(String? pin, String? confirm) {
    if (confirm == null || confirm.isEmpty) return 'Confirm your PIN';
    if (pin != confirm) return 'PINs do not match';
    return null;
  }

  static String? validateMotherName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Mother\'s name is required';
    return null;
  }
}