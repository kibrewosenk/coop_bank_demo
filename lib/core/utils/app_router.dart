import 'package:coop_bank_demo/presentation/pages/onboarding/manual_info_entry.dart';
import 'package:flutter/material.dart';
import '../../presentation/pages/dashboard/dashboard_page.dart'; // This import is correct
import '../../presentation/pages/forgot_pin/forgot_pin_page.dart';
import '../../presentation/pages/forgot_pin/reset_pin_page.dart';
import '../../presentation/pages/forgot_pin/temp_pin_review_page.dart';
import '../../presentation/pages/onboarding/get_started_page.dart';
import '../../presentation/pages/onboarding/nid_detail_confirm_page.dart';
import '../../presentation/pages/onboarding/nid_entry_page.dart';
import '../../presentation/pages/onboarding/otp_page.dart';
import '../../presentation/pages/onboarding/phone_entry_page.dart';
import '../../presentation/pages/onboarding/pin_entry_page.dart';
import '../../presentation/pages/onboarding/selfie_capture_page.dart';
import '../../presentation/pages/onboarding/under_review_page.dart';
import '../../presentation/pages/splash_page.dart';
import '../utils/shared_prefs_helper.dart';

class AppRouter {
  static const splash = '/';
  static const getStarted = '/get-started';
  static const phoneEntry = '/phone-entry';
  static const pinEntry = '/pin-entry';
  static const forgotPin = '/forgot-pin';
  static const resetPin = '/reset-pin';
  static const tempPinReview = '/temp-pin-review';
  static const nidEntry = '/nid-entry';
  static const otp = '/otp';
  static const skip = '/manual-info-entry';
  static const nidDetailConfirm = '/nid-detail-confirm';
  static const selfieCapture = '/selfie-capture';
  static const underReview = '/under-review';
  static const dashboard = '/dashboard';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // Save current route for persistence
    SharedPrefsHelper.saveOnboardingStep(settings.name ?? splash);

    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case getStarted:
        return MaterialPageRoute(builder: (_) => const GetStartedPage());
      case phoneEntry:
        return MaterialPageRoute(builder: (_) => const PhoneEntryPage());
      case pinEntry:
        return MaterialPageRoute(builder: (_) => const PinEntryPage());
      case forgotPin:
        return MaterialPageRoute(builder: (_) => const ForgotPinPage());
      case resetPin:
        return MaterialPageRoute(builder: (_) => const ResetPinPage());
      case tempPinReview:
        return MaterialPageRoute(builder: (_) => const TempPinReviewPage());
      case nidEntry:
        return MaterialPageRoute(builder: (_) => const NidEntryPage());
      case otp:
        return MaterialPageRoute(builder: (_) => const OtpPage());
      case skip:
        return MaterialPageRoute(builder: (_) => const manualInfoEntry());
      case nidDetailConfirm:
        return MaterialPageRoute(builder: (_) => const NidDetailConfirmPage());
      case selfieCapture:
        return MaterialPageRoute(builder: (_) => const SelfieCapturePage());
      case underReview:
        return MaterialPageRoute(builder: (_) => const UnderReviewPage());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text('Route not found: ${settings.name}'))),
        );
    }
  }
}