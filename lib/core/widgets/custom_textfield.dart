import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscure;
  final TextAlign textAlign; // ✅ Added
  final TextAlignVertical textAlignVertical; // ✅ Added

  const CustomTextField({
    required this.hint,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscure = false,
    this.textAlign = TextAlign.start, // ✅ Default value
    this.textAlignVertical = TextAlignVertical.center, // ✅ Default value
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscure,
      textAlign: textAlign, // ✅ applied
      textAlignVertical: textAlignVertical, // ✅ applied
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
