// Updated lib/presentation/pages/forgot_pin/forgot_pin_page.dart (NID -> OTP flow)
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../viewmodels/otp_viewmodel.dart';

class ForgotPinPage extends StatefulWidget {
  const ForgotPinPage({super.key});

  @override
  State<ForgotPinPage> createState() => _ForgotPinPageState();
}

class _ForgotPinPageState extends State<ForgotPinPage> {
  final _formKey = GlobalKey<FormState>();
  final _nidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final otpVM = Provider.of<OtpViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.forgotPin)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                hint: AppStrings.enterNid,
                controller: _nidController,
                validator: Validators.validateNid,
              ),
              const SizedBox(height: 20),
              CustomButton(
                label: AppStrings.next,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Assume NID valid, generate OTP
                    await otpVM.generateOtp(_nidController.text);
                    Navigator.pushNamed(context, AppRouter.otp); // Then to reset pin after OTP
                  } else {
                    Fluttertoast.showToast(msg: 'Invalid NID');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}