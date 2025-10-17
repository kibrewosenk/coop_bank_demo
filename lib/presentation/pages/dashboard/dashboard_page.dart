import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    HomeTab(),
    TransfersTab(),
    ServicesTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(AppStrings.dashboardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.text.withOpacity(0.6),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.swap_horiz_outlined),
              activeIcon: Icon(Icons.swap_horiz),
              label: 'Transfers',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.apps_outlined),
              activeIcon: Icon(Icons.apps),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary,
                  AppColors.primary.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'John Doe', // Replace with actual user name
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Quick Actions
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            childAspectRatio: 0.9,
            children: [
              _buildQuickAction(Icons.send, 'Send', () {}),
              _buildQuickAction(Icons.qr_code, 'Pay', () {}),
              _buildQuickAction(Icons.download, 'Receive', () {}),
              _buildQuickAction(Icons.mobile_friendly, 'Airtime', () {}),
              _buildQuickAction(Icons.receipt, 'Bills', () {}),
              _buildQuickAction(Icons.account_balance, 'Loans', () {}),
              _buildQuickAction(Icons.analytics, 'Reports', () {}),              _buildQuickAction(Icons.settings, 'More', () {}),
            ],
          ),

          const SizedBox(height: 24),

          // Account Balance Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Account Balance',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text.withOpacity(0.7),
                      ),
                    ),
                    Icon(
                      Icons.visibility_outlined,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '\$12,345.67',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Primary Account •••• 1234',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.text.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Recent Transactions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transactions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                ),
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildTransactionItem(
            'Groceries Store',
            '-\$50.00',
            'Oct 15',
            Icons.shopping_cart,
            AppColors.danger,
          ),
          _buildTransactionItem(
            'Salary Deposit',
            '+\$2,000.00',
            'Oct 1',
            Icons.account_balance,
            AppColors.success,
          ),
          _buildTransactionItem(
            'Netflix Subscription',
            '-\$15.99',
            'Sep 28',
            Icons.movie,
            AppColors.danger,
          ),
          _buildTransactionItem(
            'Transfer from Mom',
            '+\$500.00',
            'Sep 25',
            Icons.people,
            AppColors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
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

  Widget _buildTransactionItem(
      String title, String amount, String date, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.text.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

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

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Profile Header
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withOpacity(0.1),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'john.doe@email.com',
                    style: TextStyle(
                      color: AppColors.text.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Settings Options
          Card(
            child: Column(
              children: [
                _buildProfileOption(Icons.security, 'Security Settings', () {}),
                _buildProfileOption(Icons.notifications, 'Notifications', () {}),
                _buildProfileOption(Icons.language, 'Language', () {}),
                _buildProfileOption(Icons.help_outline, 'Help & Support', () {}),
                _buildProfileOption(Icons.info_outline, 'About', () {}),
                _buildProfileOption(Icons.logout, 'Logout', () {}, isLogout: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, VoidCallback onTap, {bool isLogout = false}) {
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
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppColors.text.withOpacity(0.5),
      ),
      onTap: onTap,
    );
  }
}