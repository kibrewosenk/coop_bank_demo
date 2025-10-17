# Core folders
mkdir -p lib/core/constants lib/core/utils lib/core/widgets
mkdir -p lib/data/dummy_data lib/data/models lib/data/services
mkdir -p lib/presentation/pages/onboarding lib/presentation/pages/dashboard lib/presentation/pages/forgot_pin
mkdir -p lib/presentation/viewmodels
mkdir -p lib/theme

# Create main app files
touch lib/main.dart

# Core
touch lib/core/constants/app_colors.dart
touch lib/core/constants/app_strings.dart
touch lib/core/constants/app_assets.dart
touch lib/core/utils/validators.dart
touch lib/core/utils/shared_prefs_helper.dart
touch lib/core/utils/app_router.dart
touch lib/core/widgets/custom_button.dart
touch lib/core/widgets/custom_textfield.dart
touch lib/core/widgets/pin_input.dart
touch lib/core/widgets/biometric_toggle.dart

# Data
touch lib/data/dummy_data/users.dart
touch lib/data/dummy_data/nid_data.dart
touch lib/data/dummy_data/otp_data.dart
touch lib/data/models/user_model.dart
touch lib/data/models/nid_model.dart
touch lib/data/services/auth_service.dart
touch lib/data/services/otp_service.dart
touch lib/data/services/nid_service.dart
touch lib/data/services/camera_service.dart

# Presentation
touch lib/presentation/pages/splash_page.dart
touch lib/presentation/pages/onboarding/get_started_page.dart
touch lib/presentation/pages/onboarding/phone_entry_page.dart
touch lib/presentation/pages/onboarding/otp_page.dart
touch lib/presentation/pages/onboarding/pin_entry_page.dart
touch lib/presentation/pages/onboarding/nid_entry_page.dart
touch lib/presentation/pages/onboarding/nid_detail_confirm_page.dart
touch lib/presentation/pages/onboarding/selfie_capture_page.dart
touch lib/presentation/pages/onboarding/under_review_page.dart
touch lib/presentation/pages/dashboard/dashboard_page.dart
touch lib/presentation/pages/forgot_pin/forgot_pin_page.dart
touch lib/presentation/pages/forgot_pin/reset_pin_page.dart
touch lib/presentation/pages/forgot_pin/temp_pin_review_page.dart

# ViewModels
touch lib/presentation/viewmodels/auth_viewmodel.dart
touch lib/presentation/viewmodels/otp_viewmodel.dart
touch lib/presentation/viewmodels/nid_viewmodel.dart
touch lib/presentation/viewmodels/camera_viewmodel.dart

# Theme
touch lib/theme/app_theme.dart
touch lib/theme/text_styles.dart
