import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../viewmodels/nid_viewmodel.dart';
import '../../viewmodels/otp_viewmodel.dart';

class NidEntryPage extends StatefulWidget {
  const NidEntryPage({super.key});

  @override
  State<NidEntryPage> createState() => _NidEntryPageState();
}

class _NidEntryPageState extends State<NidEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final _nidController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nidController.dispose();
    super.dispose();
  }

  Future<void> _handleNidSubmission() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final nidVM = context.read<NidViewModel>();
      final otpVM = context.read<OtpViewModel>();

      final data = await nidVM.fetchNidData(_nidController.text);

      if (!mounted) return;

      if (data != null) {
        await otpVM.generateOtp(_nidController.text);

        if (mounted) {
          Navigator.pushNamed(context, AppRouter.otp);
        }
      } else {
        _showErrorDialog('Invalid NID', 'The National ID you entered could not be found. Please check the number and try again.');
      }
    } catch (error) {
      if (mounted) {
        _showErrorDialog('Connection Error', 'Unable to verify NID. Please check your internet connection and try again.');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
  Future<void> _handleNidSkip() async {

    setState(() => _isLoading = true);

          Navigator.pushNamed(context, AppRouter.skip);

        setState(() => _isLoading = false);


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
          'Verify Identity',
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
                const SizedBox(height: 5),
                Text(
                  'National ID Verification',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Enter your National ID number to verify your identity and continue with account registration.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.text.withOpacity(0.7),
                    height: 1.5,
                  ),
                ),

                // Illustration/Icon
                const SizedBox(height: 15),
                Center(
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.badge_outlined,
                      size: 50,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // NID Input Section
                Text(
                  'National ID Number',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 5),
                Stack(
                  children: [
                    CustomTextField(
                      hint: AppStrings.enterNid,
                      controller: _nidController,
                      validator: Validators.validateNid,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                    ),
                    Positioned(
                      left: 16,
                      top: 16,
                      child: Icon(
                        Icons.credit_card,
                        color: AppColors.primary.withOpacity(0.6),
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Helper text
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 14,
                      color: AppColors.text.withOpacity(0.5),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Enter your 10-digit National ID number',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.text.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),

                // Submit Button
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 40,
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
                    onPressed: _handleNidSubmission,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 40,
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
                    label: 'Skip',
                    onPressed: _handleNidSkip,
                  ),
                ),

                // Security and Information Section
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary.withOpacity(0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.security,
                            size: 20,
                            color: AppColors.success,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Your Data is Secure',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.text,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your National ID information is encrypted and used only for identity verification. We comply with all data protection regulations.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.text.withOpacity(0.6),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                // Process Steps
                const SizedBox(height: 24),
                Text(
                  'Next Steps:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 12),
                _buildProcessStep('1. Enter National ID', 'Verify your identity'),
                _buildProcessStep('2. OTP Verification', 'Secure code sent to your phone'),
                _buildProcessStep('3. Account Setup', 'Complete your profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProcessStep(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              size: 14,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.text,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.text.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}