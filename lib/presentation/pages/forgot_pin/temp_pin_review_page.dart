import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/custom_button.dart';

class TempPinReviewPage extends StatelessWidget {
  const TempPinReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Temporary PIN Review')),
      body: const Center(
        child: Text('Under review - Wait for SMS or visit branch.'),
      ),
    );
  }
}