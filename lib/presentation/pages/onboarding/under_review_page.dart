import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/widgets/custom_button.dart';

class UnderReviewPage extends StatefulWidget {
  const UnderReviewPage({super.key});

  @override
  State<UnderReviewPage> createState() => _UnderReviewPageState();
}

class _UnderReviewPageState extends State<UnderReviewPage> {
  bool _isChecking = false;

  Future<void> _checkApprovalStatus() async {
    setState(() => _isChecking = true);
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final approved = DateTime.now().second % 2 == 0;
    if (approved) {
      Navigator.pushReplacementNamed(context, AppRouter.dashboard);
    } else {
      _showStillReviewingDialog();
    }

    setState(() => _isChecking = false);
  }

  void _showStillReviewingDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Still Under Review'),
        content: const Text('Your account is still being reviewed. We\'ll notify you via SMS once complete.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSelfieInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Selfie Photo'),
        content: const Text('Adding a selfie can help speed up verification.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRouter.selfieCapture);
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Illustration
              const SizedBox(height: 10),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.verified_user_outlined,
                  size: 50,
                  color: AppColors.primary,
                ),
              ),

              // Status Message
              const SizedBox(height: 16),
              Text(
                'Account Under Review',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Your account application is currently being reviewed by our team. This process usually takes 1-2 business days.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.text.withOpacity(0.7),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              // Immediate Assistance Section
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.support_agent,
                      size: 32,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Need immediate assistance?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.visitBranch,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.text.withOpacity(0.7),
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Action Buttons
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: _showSelfieInfoDialog,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.camera_alt, size: 18),
                  label: const Text(
                    'Attach Selfie',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: _isChecking
                    ? ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
                    : ElevatedButton(
                  onPressed: _checkApprovalStatus,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Check Status',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // Notification Info - CLOSE TO BUTTONS
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.notifications_active,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'We will notify you via SMS once your account is approved.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.text.withOpacity(0.7),
                        ),
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