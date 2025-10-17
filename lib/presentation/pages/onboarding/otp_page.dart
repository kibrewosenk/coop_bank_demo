import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../viewmodels/otp_viewmodel.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  String? _identifier;
  bool _isLoading = false;
  bool _isResending = false;
  int _countdown = 60;

  @override
  void initState() {
    super.initState();
    _identifier = '123456'; // Replace with actual identifier
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generateOtp();
      _startCountdown();
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _generateOtp() async {
    setState(() => _isLoading = true);
    try {
      await Provider.of<OtpViewModel>(context, listen: false)
          .generateOtp(_identifier!);
    } catch (error) {
      if (mounted) {
        _showErrorDialog('Error', 'Failed to generate OTP. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _resendOtp() async {
    setState(() {
      _isResending = true;
      _countdown = 60;
    });

    try {
      await Provider.of<OtpViewModel>(context, listen: false)
          .generateOtp(_identifier!);
      if (mounted) {
        _showSuccessDialog('OTP Sent', 'A new OTP has been sent to your registered phone number.');
      }
      _startCountdown();
    } catch (error) {
      if (mounted) {
        _showErrorDialog('Error', 'Failed to resend OTP. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() => _isResending = false);
      }
    }
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _countdown > 0) {
        setState(() => _countdown--);
        _startCountdown();
      }
    });
  }

  Future<void> _handleOtpSubmission() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final otpVM = Provider.of<OtpViewModel>(context, listen: false);
      final valid = await otpVM.validateOtp(_identifier!, _otpController.text);

      if (!mounted) return;

      if (valid) {
        Navigator.pushNamed(context, AppRouter.nidDetailConfirm);
      } else {
        _showErrorDialog('Invalid OTP', 'The OTP you entered is incorrect. Please check and try again.');
      }
    } catch (error) {
      if (mounted) {
        _showErrorDialog('Error', 'An error occurred during verification. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'OTP Verification',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.text,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                const SizedBox(height: 20),
                Text(
                  'Enter OTP Code',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'We\'ve sent a 6-digit verification code to your registered phone number.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.text.withOpacity(0.7),
                    height: 1.5,
                  ),
                ),

                // OTP Illustration
                const SizedBox(height: 40),
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.sms_outlined,
                      size: 50,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // OTP Input Section
                Text(
                  'Verification Code',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 8),
                Stack(
                  children: [
                    CustomTextField(
                      hint: AppStrings.enterOtp,
                      controller: _otpController,
                      validator: Validators.validateOtp,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                    ),
                    Positioned(
                      left: 16,
                      top: 16,
                      child: Icon(
                        Icons.lock_outline,
                        color: AppColors.primary.withOpacity(0.6),
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Helper text
                Text(
                  'Enter the 6-digit code sent to your phone',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.text.withOpacity(0.5),
                  ),
                ),

                // Resend OTP Section
                const SizedBox(height: 20),
                Center(
                  child: _countdown > 0
                      ? Text(
                    'Resend OTP in $_countdown seconds',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.text.withOpacity(0.6),
                    ),
                  )
                      : TextButton(
                    onPressed: _isResending ? null : _resendOtp,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                    ),
                    child: _isResending
                        ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                        : const Text(
                      'Resend OTP',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // Submit Button
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: _isLoading
                      ? ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  )
                      : CustomButton(
                    label: AppStrings.next,
                    onPressed: _handleOtpSubmission,
                  ),
                ),

                // Security Note
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary.withOpacity(0.1)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.security,
                        size: 20,
                        color: AppColors.success,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'For your security, this OTP will expire in 10 minutes. Do not share it with anyone.',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.text.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Help Section
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _showErrorDialog(
                      'Need Help?',
                      'If you didn\'t receive the OTP, please check your phone number and try again. Contact customer support if the issue persists.',
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.help_outline,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Need help with OTP?',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}