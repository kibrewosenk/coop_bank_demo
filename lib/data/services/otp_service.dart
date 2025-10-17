// Updated lib/data/services/otp_service.dart (working dummy OTP)
import 'package:fluttertoast/fluttertoast.dart'; // To show dummy OTP
import '../dummy_data/otp_data.dart';

class OtpService {
  Future<String> generateOtp(String identifier) async {
    final otp = dummyOtpData[identifier] ?? (DateTime.now().millisecond % 10000).toString().padLeft(4, '0');
    dummyOtpData[identifier] = otp; // Store/update
    Fluttertoast.showToast(msg: 'Dummy OTP: $otp'); // Show for demo (in real, send SMS)
    return otp;
  }

  Future<bool> validateOtp(String identifier, String otp) async {
    return dummyOtpData[identifier] == otp;
  }
}