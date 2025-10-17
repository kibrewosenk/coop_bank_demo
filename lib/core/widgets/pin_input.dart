import 'package:flutter/material.dart';

class PinInput extends StatelessWidget {
  final TextEditingController controller;
  final int length;
  final String hint;
  final bool obscure;
  final String? Function(String?)? validator;

  const PinInput({
    required this.controller,
    this.length = 4,
    this.hint = 'PIN ****',
    this.obscure = true,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.number,
      obscureText: obscure,
      maxLength: length,
      decoration: InputDecoration(
        counterText: '',
        hintText: hint,
        prefixIcon: const Icon(Icons.lock_outline), // 🔒 Add lock icon here
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

}