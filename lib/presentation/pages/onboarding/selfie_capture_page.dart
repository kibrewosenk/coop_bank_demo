import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/widgets/custom_button.dart';
import '../../viewmodels/camera_viewmodel.dart';

class SelfieCapturePage extends StatefulWidget {
  const SelfieCapturePage({super.key});

  @override
  State<SelfieCapturePage> createState() => _SelfieCapturePageState();
}

class _SelfieCapturePageState extends State<SelfieCapturePage> {
  File? _selfie;
  bool _isCapturing = false;

  Future<void> _captureSelfie() async {
    setState(() => _isCapturing = true);

    try {
      final cameraVM = context.read<CameraViewModel>();
      final photo = await cameraVM.captureSelfie();

      if (mounted) {
        setState(() => _selfie = photo);
      }
    } catch (error) {
      if (mounted) {
        _showErrorDialog('Camera Error', 'Unable to access camera. Please check permissions.');
      }
    } finally {
      if (mounted) {
        setState(() => _isCapturing = false);
      }
    }
  }

  void _submitSelfie() {
    if (_selfie != null) {
      Navigator.pushNamed(context, AppRouter.underReview);
    }
  }

  void _retakeSelfie() {
    setState(() => _selfie = null);
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Header
              const SizedBox(height: 10),
              Text(
                'Take Selfie',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Capture a clear selfie for identity verification',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.text.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),

              // Camera Preview / Captured Image
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                  ),
                  child: _selfie != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      _selfie!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 60,
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No photo captured',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.text.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Guidelines
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Photo Guidelines',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildGuideline('Face should be clearly visible'),
                    _buildGuideline('Good lighting conditions'),
                    _buildGuideline('No sunglasses or hats'),
                    _buildGuideline('Neutral background'),
                  ],
                ),
              ),

              // Action Buttons
              const SizedBox(height: 20),
              if (_selfie == null)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: _isCapturing
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
                      : ElevatedButton.icon(
                    onPressed: _captureSelfie,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.camera_alt, size: 20),
                    label: const Text(
                      'Capture Selfie',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

              if (_selfie != null) ...[
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          onPressed: _retakeSelfie,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Retake',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _submitSelfie,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuideline(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            size: 16,
            color: AppColors.success,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.text.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}