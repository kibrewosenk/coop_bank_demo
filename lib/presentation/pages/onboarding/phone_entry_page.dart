import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../viewmodels/auth_viewmodel.dart';

class PhoneEntryPage extends StatefulWidget {
  const PhoneEntryPage({super.key});

  @override
  State<PhoneEntryPage> createState() => _PhoneEntryPageState();
}

class _PhoneEntryPageState extends State<PhoneEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handlePhoneSubmission() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authVM = Provider.of<AuthViewModel>(context, listen: false);
      authVM.phone = _phoneController.text;

      final exists = await authVM.checkUserExists(_phoneController.text);

      if (mounted) {
        if (exists) {
          Navigator.pushNamed(context, AppRouter.pinEntry);
        } else {
          Navigator.pushNamed(context, AppRouter.nidEntry);
        }
      }
    } catch (error) {
      if (mounted) {
        _showErrorDialog('Connection Error', 'Please check your internet connection and try again.');
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
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
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
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: false,
        title: Text(
          'Back to Get start',
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
                'Enter Your Phone Number',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'We\'ll use this number to verify your identity and secure your account.',
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
                    Icons.phone_iphone,
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
                    // Phone input with manual prefix icon
                    Stack(
                      children: [
                        CustomTextField(
                          hint: AppStrings.enterPhone,
                          controller: _phoneController,
                          validator: Validators.validatePhone,
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,


                        ),
                        Positioned(
                          left: 16,
                          top: 16,
                          child: Icon(
                            Icons.phone,
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
                        'Enter your 10-digit phone number',
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
                        onPressed: _handlePhoneSubmission,
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
                              'Your phone number is secure and will only be used for verification.',
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