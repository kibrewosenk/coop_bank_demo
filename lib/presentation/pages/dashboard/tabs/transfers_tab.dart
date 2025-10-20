import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class TransfersTab extends StatelessWidget {
  const TransfersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Money Transfer',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 20),
          _buildTransferOption(Icons.person_add, 'To Another Account', () {}),
          _buildTransferOption(Icons.qr_code_scanner, 'QR Code Transfer', () {}),
          _buildTransferOption(Icons.phone_iphone, 'Mobile Number', () {}),
          _buildTransferOption(Icons.account_balance, 'To Other Banks', () {}),
          _buildTransferOption(Icons.language, 'International', () {}),
        ],
      ),
    );
  }

  Widget _buildTransferOption(IconData icon, String title, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.text,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.text.withOpacity(0.5)),
        onTap: onTap,
      ),
    );
  }
}