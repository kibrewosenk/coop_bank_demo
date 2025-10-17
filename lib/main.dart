// Updated lib/main.dart (apply theme)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_colors.dart';
import 'core/constants/app_strings.dart';
import 'core/utils/app_router.dart';
import 'core/utils/shared_prefs_helper.dart';
import 'presentation/viewmodels/auth_viewmodel.dart';
import 'presentation/viewmodels/camera_viewmodel.dart';
import 'presentation/viewmodels/nid_viewmodel.dart';
import 'presentation/viewmodels/otp_viewmodel.dart';
import 'theme/app_theme.dart'; // Import theme

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper.init();
  runApp(const CoopBankDemoApp());
}

class CoopBankDemoApp extends StatelessWidget {
  const CoopBankDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => OtpViewModel()),
        ChangeNotifierProvider(create: (_) => NidViewModel()),
        ChangeNotifierProvider(create: (_) => CameraViewModel()),
      ],
      child: MaterialApp(
        title: AppStrings.appTitle,
        theme: appTheme, // Use updated theme
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: SharedPrefsHelper.getOnboardingStep() ?? AppRouter.splash,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}