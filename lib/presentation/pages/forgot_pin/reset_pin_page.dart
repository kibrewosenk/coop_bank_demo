import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/app_router.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/pin_input.dart';

class ResetPinPage extends StatefulWidget {
  const ResetPinPage({super.key});

  @override
  State<ResetPinPage> createState() => _ResetPinPageState();
}

class _ResetPinPageState extends State<ResetPinPage> {
  final _formKey = GlobalKey<FormState>();
  final _tempPinController = TextEditingController();
  final _newPinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset PIN')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              PinInput(controller: _tempPinController, hint: AppStrings.tempPin),
              PinInput(controller: _newPinController, hint: AppStrings.newPin, validator: Validators.validatePin),
              PinInput(
                controller: _confirmPinController,
                hint: AppStrings.confirmPin,
                validator: (val) => Validators.confirmPin(_newPinController.text, val),
              ),
              const SizedBox(height: 20),
              const Text('Your request is under review. Wait for temporary PIN or visit branch.'),
              CustomButton(
                label: AppStrings.next,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Submit reset
                    Navigator.pushNamed(context, AppRouter.tempPinReview);
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