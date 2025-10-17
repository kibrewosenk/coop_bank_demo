import 'package:coop_bank_demo/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/app_router.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height,
            ),
            child: Column(
              children: [
                // Header section with gradient - Fixed height based on screen size
                Container(
                  height: isSmallScreen ? size.height * 0.35 : size.height * 0.4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withOpacity(0.9),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Bank Logo
                      Container(
                        width: isSmallScreen ? 80 : 100,
                        height: isSmallScreen ? 80 : 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          // 'asset/images/logo.png',
                          AppAssets.logo,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Coopbank',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 24 : 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),

                // Content section - Made more compact for small screens
                Padding(
                  padding: EdgeInsets.all(isSmallScreen ? 24.0 : 32.0),
                  child: Column(
                    children: [
                      // Welcome title
                      Text(
                        AppStrings.welcome,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 28 : 32,
                          fontWeight: FontWeight.w700,
                          color: AppColors.text,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: isSmallScreen ? 12 : 16),

                      // Welcome subtitle
                      Text(
                        'Welcome to Coopbank Mobile Banking. Secure, fast, and convenient banking at your fingertips.',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 14 : 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.text.withOpacity(0.7),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: isSmallScreen ? 24 : 32),

                      // Features list - More compact for small screens
                      _buildFeatureRow(
                          Icons.security,
                          'Secure & Protected',
                          isSmallScreen
                      ),
                      SizedBox(height: isSmallScreen ? 8 : 12),
                      _buildFeatureRow(
                          Icons.bolt,
                          'Fast Transactions',
                          isSmallScreen
                      ),
                      SizedBox(height: isSmallScreen ? 8 : 12),
                      _buildFeatureRow(
                          Icons.phone_iphone,
                          '24/7 Access',
                          isSmallScreen
                      ),

                      // Spacer that adapts to screen size
                      SizedBox(height: isSmallScreen ? 20 : 40),

                      // Get Started button
                      SizedBox(
                        width: double.infinity,
                        height: isSmallScreen ? 50 : 56,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, AppRouter.phoneEntry),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 16 : 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: isSmallScreen ? 12 : 16),

                      // Secure badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.verified_user,
                            size: isSmallScreen ? 14 : 16,
                            color: AppColors.success,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Bank-Grade Security',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 12 : 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.text.withOpacity(0.6),
                            ),
                          ),
                        ],
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

  Widget _buildFeatureRow(IconData icon, String text, bool isSmallScreen) {
    return Row(
      children: [
        Container(
          width: isSmallScreen ? 36 : 40,
          height: isSmallScreen ? 36 : 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: isSmallScreen ? 18 : 20,
            color: AppColors.primary,
          ),
        ),
        SizedBox(width: isSmallScreen ? 12 : 16),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              fontWeight: FontWeight.w500,
              color: AppColors.text,
            ),
          ),
        ),
      ],
    );
  }
}