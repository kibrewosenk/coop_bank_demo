// Updated lib/theme/app_theme.dart
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import 'text_styles.dart';

ThemeData get appTheme => ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: TextTheme(
        bodyLarge: TextStyles.bodyLarge,
        bodyMedium: TextStyles.bodyMedium,
        // Add more
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.secondary,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: AppColors.accent,
      ),
      // Apply colors to other elements as needed
    );