import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool enabled;

  const CustomButton({
    required this.label,
    required this.onPressed,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label),
    );
  }
}