import 'package:flutter/material.dart';

class BiometricToggle extends StatelessWidget {
  final bool enabled;
  final ValueChanged<bool> onChanged;

  const BiometricToggle({required this.enabled, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.fingerprint),
        const SizedBox(width: 8),
        const Expanded(child: Text('Use biometric (optional)')),
        Switch(value: enabled, onChanged: onChanged),
      ],
    );
  }
}