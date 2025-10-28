import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/widgets/pin_input.dart';
import '../../../data/models/user_model.dart';
import '../../viewmodels/auth_viewmodel.dart';

class manualInfoEntry extends StatefulWidget {
  const manualInfoEntry({super.key});

  @override
  State<manualInfoEntry> createState() => _ManualInfoEntryState();
}

class _ManualInfoEntryState extends State<manualInfoEntry> {
  final _formKey = GlobalKey<FormState>();
  final _firstController = TextEditingController();
  final _secondController = TextEditingController();
  final _lastController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  final _motherController = TextEditingController();
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  String? _gender;
  bool _acceptTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    _lastController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
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
      final authVM = context.read<AuthViewModel>();

      final user = UserModel(
        fullname: '${_firstController.text} ${_secondController.text} ${_lastController.text}'.trim(),
        phone: _phoneController.text,
        nid: '',
        pin: _pinController.text,
        motherName: _motherController.text,
        isActivated: true,
        useBiometric: false,
      );

      await authVM.registerUser(user);
      await authVM.savePin(_pinController.text);

      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          AppRouter.dashboard,
          arguments: true,
        );
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
          'Enter your Details',
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
                      // Combined Details Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.primary.withOpacity(0.1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // First Name
                            Text(
                              'Full Name',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.text,
                              ),
                            ),
                            const SizedBox(height: 2),
                            CustomTextField(
                              hint: 'Enter full name',
                              controller: _firstController,
                              validator: (val) => val!.isEmpty ? 'Full name required' : null,
                            ),
                            const SizedBox(height: 5),

                            // Email
                            Text(
                              'Email (Optional)',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.text,
                              ),
                            ),
                            const SizedBox(height: 2),
                            CustomTextField(
                              hint: 'Enter email',
                              controller: _emailController,
                              validator: (val) {
                                if (val!.isEmpty) return null;
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                                  return 'Invalid email format';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 2),


                            // Date of Birth
                            Text(
                              'Date of Birth (dd/mm/yy)',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.text,
                              ),
                            ),
                            const SizedBox(height: 2),
                            CustomTextField(
                              hint: 'dd/mm/yy',
                              controller: _dobController,
                              validator: (val) {
                                if (val!.isEmpty) return 'Date of birth required';
                                if (!RegExp(r'^\d{2}/\d{2}/\d{2}$').hasMatch(val)) {
                                  return 'Invalid format (dd/mm/yy)';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 2),

                            // Gender
                            Text(
                              'Gender',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.text,
                              ),
                            ),
                            FormField<String>(
                              validator: (val) => _gender == null ? 'Gender required' : null,
                              builder: (FormFieldState<String> state) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: RadioListTile<String>(
                                            title: const Text('Male'),
                                            value: 'Male',
                                            groupValue: _gender,
                                            onChanged: (value) {
                                              setState(() {
                                                _gender = value;
                                                state.didChange(value);
                                              });
                                            },
                                            contentPadding: EdgeInsets.zero,
                                            dense: true,
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile<String>(
                                            title: const Text('Female'),
                                            value: 'Female',
                                            groupValue: _gender,
                                            onChanged: (value) {
                                              setState(() {
                                                _gender = value;
                                                state.didChange(value);
                                              });
                                            },
                                            contentPadding: EdgeInsets.zero,
                                            dense: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (state.hasError)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          state.errorText!,
                                          style: const TextStyle(color: Colors.red, fontSize: 12),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      // Mother's Name
                      const SizedBox(height: 2),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Mother's Maiden Name",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      CustomTextField(
                        hint: AppStrings.enterMotherName,
                        controller: _motherController,
                        validator: Validators.validateMotherName,
                      ),

                      // PIN Setup
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Set Up Your PIN',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      PinInput(
                        controller: _pinController,
                        validator: Validators.validatePin,
                        hint: 'Enter 4-digit PIN',
                      ),
                      const SizedBox(height: 2),
                      PinInput(
                        controller: _confirmPinController,
                        hint: 'Confirm 4-digit PIN',
                        validator: (val) => Validators.confirmPin(_pinController.text, val),
                      ),

                      // Terms and Conditions
                      const SizedBox(height:5),
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
                            const SizedBox(width: 2),
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
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ),

            // Fixed Bottom Button - Always Visible
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
}