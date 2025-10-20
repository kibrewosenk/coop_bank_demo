import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../viewmodels/dashboard_viewmodel.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool _showAccountPopup = false;

  void _switchToNextAccount(DashboardViewModel dashboardVM) {
    final accounts = dashboardVM.accounts;
    if (accounts.isEmpty) return;

    final currentIndex = accounts.indexWhere(
            (account) => account.id == dashboardVM.currentAccount?.id
    );
    final nextIndex = (currentIndex + 1) % accounts.length;
    dashboardVM.switchAccount(accounts[nextIndex].id);
  }

  void _switchToPreviousAccount(DashboardViewModel dashboardVM) {
    final accounts = dashboardVM.accounts;
    if (accounts.isEmpty) return;

    final currentIndex = accounts.indexWhere(
            (account) => account.id == dashboardVM.currentAccount?.id
    );
    final previousIndex = currentIndex > 0 ? currentIndex - 1 : accounts.length - 1;
    dashboardVM.switchAccount(accounts[previousIndex].id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(
      builder: (context, dashboardVM, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Enhanced Header with Account Balance
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
                    // Greeting and Username
                    Text(
                      _getGreeting(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'John Doe',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Account Balance and Selector in Same Row
                    Stack(
                      children: [
                        Row(
                          children: [
                            // Account Balance
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dashboardVM.isBalanceVisible
                                        ? '\$${dashboardVM.currentAccount?.balance.toStringAsFixed(2) ?? '0.00'}'
                                        : '••••••',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Available Balance',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Account Selector with Double Arrows
                            Container(
                              width: 120,
                              child: Column(
                                children: [
                                  // Account Info (Clickable for popup)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _showAccountPopup = true;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            dashboardVM.currentAccount?.accountType ?? 'Primary',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            '10****${dashboardVM.currentAccount?.accountNumber ?? '1234'}',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white.withOpacity(0.8),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),

                                  // Arrow Buttons
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Up Arrow - Previous Account
                                      GestureDetector(
                                        onTap: () {
                                          _switchToPreviousAccount(dashboardVM);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.2),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.keyboard_arrow_up,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      // Down Arrow - Next Account
                                      GestureDetector(
                                        onTap: () {
                                          _switchToNextAccount(dashboardVM);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.2),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Account Popup - Embedded inside the card
                        if (_showAccountPopup)
                          Positioned(
                            top: 60,
                            right: 0,
                            child: Container(
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  // Popup header with close button
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Select Account',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.close, size: 18),
                                          onPressed: () {
                                            setState(() {
                                              _showAccountPopup = false;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Accounts list
                                  ...dashboardVM.accounts.map((account) {
                                    final lastDigits = account.accountNumber.length > 2
                                        ? account.accountNumber.substring(account.accountNumber.length - 2)
                                        : account.accountNumber;
                                    final isSelected = dashboardVM.currentAccount?.id == account.id;

                                    return ListTile(
                                      leading: Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.account_balance_wallet,
                                          size: 16,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      title: Text(
                                        account.accountType,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.text,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '10****$lastDigits',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.text.withOpacity(0.6),
                                        ),
                                      ),
                                      trailing: isSelected
                                          ? Icon(Icons.check, size: 16, color: AppColors.primary)
                                          : null,
                                      onTap: () {
                                        dashboardVM.switchAccount(account.id);
                                        setState(() {
                                          _showAccountPopup = false;
                                        });
                                      },
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Total Balance Section
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Balance',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                dashboardVM.isBalanceVisible
                                    ? '\$${dashboardVM.totalBalance.toStringAsFixed(2)}'
                                    : '••••••',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 12),
                              GestureDetector(
                                onTap: () {
                                  dashboardVM.toggleBalanceVisibility();
                                },
                                child: Icon(
                                  dashboardVM.isBalanceVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
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
                  _buildQuickAction(Icons.analytics, 'Reports', () {}),
                  _buildQuickAction(Icons.settings, 'More', () {}),
                ],
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
      },
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning!';
    if (hour < 17) return 'Good Afternoon!';
    return 'Good Evening!';
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