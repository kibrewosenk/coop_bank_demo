import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';//unused import
import '../../../core/utils/app_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () => Navigator.pushReplacementNamed(context, AppRouter.getStarted));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            // Top spacer
            const Expanded(flex: 2, child: SizedBox()),

            // Main content
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Bank Logo - Replace with your actual logo asset
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.account_balance,
                      size: 60,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Bank Name
                  const Text(
                    'Bank Smarter Live Better!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Tagline
                  const Text(
                    'Banking Made Simple',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),

            // Loading section
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  // Loading indicator
                  Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white.withOpacity(0.8),
                      ),
                      strokeWidth: 3,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Loading text
                  const Text(
                    'Loading...',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}