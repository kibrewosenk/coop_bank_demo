import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/pin_input.dart';
import '../../../data/dummy_data/users.dart';
import '../../../data/models/user_model.dart';
import '../../viewmodels/auth_viewmodel.dart';

class PinEntryPage extends StatefulWidget {
  const PinEntryPage({super.key});

  @override
  State<PinEntryPage> createState() => _PinEntryPageState();
}

class _PinEntryPageState extends State<PinEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final _pinController = TextEditingController();
  bool _isLoading = false;
  int _attemptCount = 0;
  bool _enableBiometric = false;

  @override
  void initState() {
    super.initState();
    _checkExistingBiometricSetting();
  }

  void _checkExistingBiometricSetting() {
    final authVM = context.read<AuthViewModel>();
    if (authVM.phone != null) {
      final user = dummyUsers.firstWhere(
            (u) => u.phone == authVM.phone,
        orElse: () => UserModel(fullname:'',phone: '', nid: '', pin: '', motherName: ''),
      );
      setState(() {
        _enableBiometric = user.useBiometric;
      });
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _handlePinSubmission() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authVM = context.read<AuthViewModel>();
      final valid = await authVM.validatePin(_pinController.text);

      if (!mounted) return;

      if (valid) {
        _attemptCount = 0;

        // Note: Biometric preference would be saved here in a real app
        // For now, we just proceed with login
        print('Biometric preference: $_enableBiometric'); // For debugging

        if (authVM.phone != null) {
          final user = dummyUsers.firstWhere(
                (u) => u.phone == authVM.phone,
            orElse: () => UserModel(fullname:'',phone: '', nid: '', pin: '', motherName: ''),
          );

          if (user.isActivated) {
            Navigator.pushReplacementNamed(context, AppRouter.dashboard);
          } else {
            Navigator.pushReplacementNamed(context, AppRouter.underReview);
          }
        }
      } else {
        _attemptCount++;
        _showErrorDialog(
          'Invalid PIN',
          _attemptCount >= 3
              ? 'You have entered an incorrect PIN multiple times. Please use Forgot PIN if you cannot remember it.'
              : 'The PIN you entered is incorrect. Please try again.',
        );
      }
    } catch (error) {
      if (mounted) {
        _showErrorDialog('Error', 'An error occurred. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleBiometricAuth() async {
    setState(() => _isLoading = true);

    try {
      final authVM = context.read<AuthViewModel>();
      final success = await authVM.authenticateWithBiometric();

      if (!mounted) return;

      if (success) {
        Navigator.pushReplacementNamed(context, AppRouter.dashboard);
      } else {
        _showErrorDialog('Authentication Failed', 'Biometric authentication failed. Please try again or use your PIN.');
      }
    } catch (error) {
      if (mounted) {
        _showErrorDialog('Error', 'Biometric authentication is not available.');
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
          'Back to change Phone number',
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
              children: [
                // Header - Reduced space
                const SizedBox(height: 20),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_outline,
                    size: 35,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Enter Your PIN',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your 4-digit PIN to access your account',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.text.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),

                // PIN Input - Reduced space
                const SizedBox(height: 30),
                PinInput(
                  controller: _pinController,
                  validator: Validators.validatePin,
                ),
                const SizedBox(height: 8),

                // Attempt counter
                if (_attemptCount > 0)
                  Text(
                    '${_attemptCount} failed attempt${_attemptCount > 1 ? 's' : ''}',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.danger,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                // Biometric Toggle - VISIBLE NOW
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                        value: _enableBiometric,
                        onChanged: _isLoading ? null : (value) {
                          setState(() {
                            _enableBiometric = value;
                          });
                        },
                        activeColor: AppColors.primary,
                      ),
                    ],
                  ),
                ),

                // Buttons Section - Reduced space
                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: _isLoading
                      ? ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
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
                    onPressed: _handlePinSubmission,
                  ),
                ),

                // Quick Biometric Login Button (only shown if biometric is enabled)
                if (_enableBiometric) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: _isLoading ? null : _handleBiometricAuth,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.fingerprint, size: 20),
                      label: const Text(
                        'Quick Login with Biometric',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],

                // Forgot PIN
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _isLoading
                      ? null
                      : () => Navigator.pushNamed(context, AppRouter.forgotPin),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                  ),
                  child: const Text(
                    'Forgot PIN?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Security Note - Smaller
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.primary.withOpacity(0.1)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.security,
                        size: 16,
                        color: AppColors.success,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'PIN is encrypted and secure',
                          style: TextStyle(
                            fontSize: 11,
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
        ),
      ),
    );
  }
}