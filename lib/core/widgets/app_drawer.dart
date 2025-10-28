import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/app_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Drawer Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            color: AppColors.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'kibre',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'kibrekerie@email.com',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),

          // Drawer Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  Icons.home,
                  'Dashboard',
                      () => Navigator.pop(context),
                ),
                _buildDrawerItem(
                  Icons.account_balance_wallet,
                  'Accounts',
                      () {},
                ),
                _buildDrawerItem(
                  Icons.history,
                  'Transaction History',
                      () {},
                ),
                _buildDrawerItem(
                  Icons.receipt_long,
                  'Statements',
                      () {},
                ),
                _buildDrawerItem(
                  Icons.settings,
                  'Settings',
                      () {},
                ),
                _buildDrawerItem(
                  Icons.help_outline,
                  'Help & Support',
                      () {},
                ),
                const Divider(),
                _buildDrawerItem(
                  Icons.logout,
                  'Logout',
                      () {
                    Navigator.pop(context);
                    // Navigate to PIN page instead of getStarted
                    Navigator.pushReplacementNamed(context, AppRouter.pinEntry);
                  },
                  isLogout: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? AppColors.danger : AppColors.primary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? AppColors.danger : AppColors.text,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}