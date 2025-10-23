// Improved lib/presentation/pages/forgot_pin/forgot_pin_page.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../viewmodels/otp_viewmodel.dart';

class ForgotPinPage extends StatefulWidget {
  const ForgotPinPage({super.key});

  @override
  State<ForgotPinPage> createState() => _ForgotPinPageState();
}

class _ForgotPinPageState extends State<ForgotPinPage> {
  final _formKey = GlobalKey<FormState>();
  final _nidController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nidController.dispose();
    super.dispose();
  }

  Future<void> _handleNext() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final otpVM = Provider.of<OtpViewModel>(context, listen: false);
      await otpVM.generateOtp(_nidController.text);

      if (mounted) {
        Navigator.pushNamed(context, AppRouter.otp);
      }
    } catch (error) {
      if (mounted) {
        Fluttertoast.showToast(msg: 'Failed to generate OTP. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
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
        centerTitle: false,
        title: Text(
          'Back to PIN Entry',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              const SizedBox(height: 20),
              Text(
                'Reset Your PIN',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Enter your National ID to receive an OTP for PIN reset.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.text.withOpacity(0.7),
                  height: 1.5,
                ),
              ),

              // Illustration/Icon
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
                    Icons.lock_reset_rounded,
                    size: 50,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Form Section
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // NID input with manual prefix icon
                    Stack(
                      children: [
                        CustomTextField(
                          hint: AppStrings.enterNid,
                          controller: _nidController,
                          validator: Validators.validateNid,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                        ),
                        Positioned(
                          left: 16,
                          top: 16,
                          child: Icon(
                            Icons.badge_outlined,
                            color: AppColors.primary.withOpacity(0.6),
                            size: 20,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Helper text
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enter your National ID number',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.text.withOpacity(0.5),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Submit Button
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
                        onPressed: _handleNext,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Security Note
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
                              'You will receive an OTP on your registered mobile number for verification.',
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}