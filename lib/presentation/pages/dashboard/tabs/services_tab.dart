import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ServicesTab extends StatelessWidget {
  const ServicesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Banking Services',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 1.2,
            children: [
              _buildServiceItem(Icons.receipt_long, 'Bill Pay'),
              _buildServiceItem(Icons.credit_card, 'Cards'),
              _buildServiceItem(Icons.account_balance, 'Loans'),
              _buildServiceItem(Icons.savings, 'Savings'),
              _buildServiceItem(Icons.analytics, 'Investments'),
              _buildServiceItem(Icons.security, 'Insurance'),
              _buildServiceItem(Icons.history, 'Statement'),
              _buildServiceItem(Icons.help_center, 'Support'),
              _buildServiceItem(Icons.more_horiz, 'More'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(IconData icon, String title) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: AppColors.primary),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.text,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}