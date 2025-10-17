import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/biometric_toggle.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/widgets/pin_input.dart';
import '../../../data/models/user_model.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/nid_viewmodel.dart';

class NidDetailConfirmPage extends StatefulWidget {
  const NidDetailConfirmPage({super.key});

  @override
  State<NidDetailConfirmPage> createState() => _NidDetailConfirmPageState();
}

class _NidDetailConfirmPageState extends State<NidDetailConfirmPage> {
  final _formKey = GlobalKey<FormState>();
  final _motherController = TextEditingController();
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  bool _acceptTerms = false;
  bool _useBiometric = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _motherController.dispose();
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  Future<void> _handleRegistration() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptTerms) {
      _showErrorDialog('Terms Required', 'Please accept the terms and conditions to continue.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final nidVM = context.read<NidViewModel>();
      final authVM = context.read<AuthViewModel>();

      if (nidVM.nidData != null && nidVM.currentNid != null) {
        final user = UserModel(
          phone: nidVM.nidData!.phoneNumber,
          nid: nidVM.currentNid!,
          pin: _pinController.text,
          motherName: _motherController.text,
          isActivated: true,
          useBiometric: _useBiometric,
        );

        await authVM.registerUser(user);
        await authVM.savePin(_pinController.text);

        if (mounted) {
          Navigator.pushReplacementNamed(context, AppRouter.dashboard);
        }
      } else {
        _showErrorDialog('Data Missing', 'NID data not found. Please try again.');
      }
    } catch (error) {
      if (mounted) {
        _showErrorDialog('Registration Failed', 'Unable to complete registration. Please try again.');
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

  @override
  Widget build(BuildContext context) {
    final nidVM = Provider.of<NidViewModel>(context);
    final authVM = Provider.of<AuthViewModel>(context);

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
          'Confirm Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.text,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Confirm Your Information',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Verify your details and complete setup',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.text.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),

            // Main Content - Compact Form
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Combined Photo and Details Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.primary.withOpacity(0.1)),
                        ),
                        child: Column(
                          children: [
                            // Profile Photo
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                              ),
                              child: ClipOval(
                                child: nidVM.nidData?.photoUrl != null
                                    ? Image.asset(
                                  nidVM.nidData!.photoUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return _buildPlaceholderAvatar();
                                  },
                                )
                                    : _buildPlaceholderAvatar(),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Personal Details
                            _buildDetailRow('Full Name', nidVM.nidData?.fullName ?? 'N/A'),
                            _buildDetailRow('Gender', nidVM.nidData?.gender ?? 'N/A'),
                            _buildDetailRow('Date of Birth', nidVM.nidData?.dob ?? 'N/A'),
                            _buildDetailRow('Phone', nidVM.nidData?.phoneNumber ?? 'N/A'),
                            _buildDetailRow('Address', nidVM.nidData?.address ?? 'N/A'),
                          ],
                        ),
                      ),

                      // Mother's Name
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Mother's Maiden Name",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Stack(
                        children: [
                          CustomTextField(
                            hint: AppStrings.enterMotherName,
                            controller: _motherController,
                            validator: Validators.validateMotherName,
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                          ),
                          Positioned(
                            left: 16,
                            top: 16,
                            child: Icon(
                              Icons.person_outline,
                              color: AppColors.primary.withOpacity(0.6),
                              size: 20,
                            ),
                          ),
                        ],
                      ),

                      // PIN Setup
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Set Up Your PIN',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      PinInput(
                        controller: _pinController,
                        validator: Validators.validatePin,
                        hint: 'Enter 4-digit PIN',
                      ),
                      const SizedBox(height: 12),
                      PinInput(
                        controller: _confirmPinController,
                        hint: 'Confirm 4-digit PIN',
                        validator: (val) => Validators.confirmPin(_pinController.text, val),
                      ),

                      // Biometric Toggle - Fixed Switch
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.primary.withOpacity(0.1)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.fingerprint,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Enable Biometric Login',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                            Switch(
                              value: _useBiometric,
                              onChanged: (value) async {
                                if (value) {
                                  final available = await authVM.checkBiometric();
                                  if (available) {
                                    setState(() => _useBiometric = value);
                                  } else {
                                    _showErrorDialog(
                                      'Biometric Not Available',
                                      'Biometric authentication is not available on this device.',
                                    );
                                  }
                                } else {
                                  setState(() => _useBiometric = value);
                                }
                              },
                              activeColor: AppColors.primary,
                            ),
                          ],
                        ),
                      ),

                      // Terms and Conditions
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.primary.withOpacity(0.1)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: _acceptTerms,
                              onChanged: (val) => setState(() => _acceptTerms = val!),
                              activeColor: AppColors.primary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                AppStrings.acceptTerms,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.text.withOpacity(0.8),
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Spacer to ensure button visibility
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),

            // Fixed Bottom Button - Always Visible (FIXED BORDER SYNTAX)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: AppColors.primary.withOpacity(0.1)),
                ),
              ),
              child: SizedBox(
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
                  label: AppStrings.allDone,
                  onPressed: _handleRegistration,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderAvatar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person,
        size: 40,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.text.withOpacity(0.7),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}