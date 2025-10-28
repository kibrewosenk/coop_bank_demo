// Updated HomeTab.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_list.dart'; // Import the app_list and ads_list
import '../../../../data/models/account_model.dart';
import '../../../viewmodels/dashboard_viewmodel.dart';
// import '../../../../data/dummy_data/users.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool _showAccountPopup = false;
  bool _showAddOptionsPopup = false;

  void _switchToNextAccount(DashboardViewModel dashboardVM) {
    final accounts = dashboardVM.accounts;
    if (accounts.isEmpty || accounts.length == 1) return;

    final currentIndex = accounts.indexWhere((account) => account.id == dashboardVM.currentAccount?.id);
    final nextIndex = (currentIndex + 1) % accounts.length;
    dashboardVM.switchAccount(accounts[nextIndex].id);
  }

  void _switchToPreviousAccount(DashboardViewModel dashboardVM) {
    final accounts = dashboardVM.accounts;
    if (accounts.isEmpty || accounts.length == 1) return;

    final currentIndex = accounts.indexWhere((account) => account.id == dashboardVM.currentAccount?.id);
    final previousIndex = currentIndex > 0 ? currentIndex - 1 : accounts.length - 1;
    dashboardVM.switchAccount(accounts[previousIndex].id);
  }

  void _handleAddOption(String option, DashboardViewModel dashboardVM) {
    setState(() => _showAddOptionsPopup = false);

    switch (option) {
      case 'Create Wallet Instantly':
        _createWalletInstantly(dashboardVM);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Digital Wallet created successfully!'),
            backgroundColor: AppColors.success,
            duration: const Duration(seconds: 2),
          ),
        );
        break;
      case 'Create Account':
        _createBankAccount(dashboardVM);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Bank account created successfully!'),
            backgroundColor: AppColors.primary,
            duration: const Duration(seconds: 2),
          ),
        );
        break;
      case 'Link Existing Account':
        _linkExistingAccount(dashboardVM);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Existing account linked successfully!'),
            backgroundColor: AppColors.danger,
            duration: const Duration(seconds: 2),
          ),
        );
        break;
    }
  }

  void _createWalletInstantly(DashboardViewModel dashboardVM) {
    final newWallet = AccountModel(
      id: 'wallet_${DateTime.now().millisecondsSinceEpoch}',
      accountNumber: '09***23',
      accountType: 'Digital Wallet',
      balance: 0.0,
      currency: 'ETB',
    );

    dashboardVM.accounts.add(newWallet);
    dashboardVM.switchAccount(newWallet.id);
    dashboardVM.notifyListeners();
  }

  void _createBankAccount(DashboardViewModel dashboardVM) {
    final newAccount = AccountModel(
      id: 'account_${DateTime.now().millisecondsSinceEpoch}',
      accountNumber: '1234',
      accountType: 'Primary Account',
      balance: 12345.67,
      currency: 'ETB',
    );

    dashboardVM.accounts.add(newAccount);
    dashboardVM.switchAccount(newAccount.id);
    dashboardVM.notifyListeners();
  }

  void _linkExistingAccount(DashboardViewModel dashboardVM) {
    final existingAccount = AccountModel(
      id: 'account_${DateTime.now().millisecondsSinceEpoch + 1}',
      accountNumber: '5678',
      accountType: 'Savings Account',
      balance: 5000.00,
      currency: 'ETB',
    );

    dashboardVM.accounts.add(existingAccount);
    dashboardVM.switchAccount(existingAccount.id);
    dashboardVM.notifyListeners();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning!';
    if (hour < 17) return 'Good Afternoon!';
    return 'Good Evening!';
  }

  Widget _buildAddOptionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.text,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: AppColors.text.withOpacity(0.6),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
        color: AppColors.text.withOpacity(0.4),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
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

  Widget _buildAppGridItem(Map<String, dynamic> app) {
    return _buildQuickAction(
      app['appicon'] as IconData,
      app['appname'] as String,
          () {}, // Add navigation or action if needed
    );
  }

  Widget _buildSwipeableAdCard(Map<String, dynamic> ad) {
    return Container(
      width: MediaQuery.of(context).size.width - 32, // Full width minus padding
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              ad['adicon'] as IconData,
              color: AppColors.primary,
              size: 32,
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ad['adname'] as String,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Check out this offer!',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.text.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(
      builder: (context, dashboardVM, child) {
        final hasAccounts = dashboardVM.accounts.isNotEmpty;
        final canSwitchAccounts = dashboardVM.accounts.length > 1;

        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with account details
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Balance + Greeting
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _getGreeting(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                  const SizedBox(height: 1),
                                  const Text(
                                    'Kibre',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 1),
                                  Text(
                                    dashboardVM.isBalanceVisible && hasAccounts
                                        ? '\$${dashboardVM.currentAccount?.balance.toStringAsFixed(2) ?? '0.00'}'
                                        : hasAccounts ? '••••••' : 'N/A',
                                    style: const TextStyle(
                                      fontSize: 16,
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

                            // Right side — Account switcher + Add button
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 10),
                                    // Up Arrow - Only show if multiple accounts
                                    if (canSwitchAccounts)
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [

                                          GestureDetector(
                                            onTap: () => _switchToPreviousAccount(dashboardVM),
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.2),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.keyboard_arrow_up,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),

                                        ],
                                      )
                                    else
                                      const SizedBox(width: 30),
                                    const SizedBox(width: 30),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        GestureDetector(
                                          onTap: () {
                                            setState(() => _showAddOptionsPopup = true);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.2),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                                const SizedBox(height: 6),

                                // Account Info Box
                                GestureDetector(
                                  onTap: hasAccounts && canSwitchAccounts ? () {
                                    setState(() => _showAccountPopup = true);
                                  } : null,
                                  child: Container(
                                    width: 150,
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),

                                    child: Column(

                                      children: [

                                        Text(
                                          hasAccounts
                                              ? dashboardVM.currentAccount?.accountType ?? 'Primary'
                                              : 'N/A',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          hasAccounts
                                              ? '••••${dashboardVM.currentAccount?.accountNumber.substring(dashboardVM.currentAccount!.accountNumber.length - 4) ?? '1234'}'
                                              : 'No accounts',
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

                                const SizedBox(height: 6),

                                // Down Arrow - Only show if multiple accounts


                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            if (canSwitchAccounts)
                              GestureDetector(
                                onTap: () => _switchToNextAccount(dashboardVM),
                                child: Container(

                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                    size: 20,
                                  ),

                                ),

                              )

                            else
                              const SizedBox(height: 28),
                            const SizedBox(width: 60),
                          ],
                        ),
                        const SizedBox(height: 5),

                        // Total balance section
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
                                    dashboardVM.isBalanceVisible && hasAccounts
                                        ? '\$${dashboardVM.totalBalance.toStringAsFixed(2)}'
                                        : hasAccounts ? '••••••' : 'N/A',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // Hide visibility toggle if no accounts
                                  if (hasAccounts) GestureDetector(
                                    onTap: dashboardVM.toggleBalanceVisibility,
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

                  const SizedBox(height: 5),

                  // Quick Actions
                  const Text(
                    'Quick Actions',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 2),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    childAspectRatio: 1,
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

                  const SizedBox(height: 2),

                  // Ads section - horizontal slider, one at a time, full width
                  SizedBox(
                    height: 100, // Adjust height based on card size
                    child: PageView.builder(
                      itemCount: adsList.length,
                      itemBuilder: (context, index) {
                        return _buildSwipeableAdCard(adsList[index]);
                      },
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Recent Apps - grid view
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Apps',
                        style: TextStyle(
                          fontSize: 16,
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
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    childAspectRatio: 0.9,
                    children: appList.take(4).map((app) => _buildAppGridItem(app)).toList(),
                  ),
                ],
              ),
            ),

            // Account Popup - Only show if multiple accounts
            if (_showAccountPopup && canSwitchAccounts)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => setState(() => _showAccountPopup = false),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    alignment: Alignment.center,
                    child: Container(
                      width: 260,
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Popup header
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
                                    setState(() => _showAccountPopup = false);
                                  },
                                ),
                              ],
                            ),
                          ),

                          // Account list
                          ...dashboardVM.accounts.map((account) {
                            final lastDigits = account.accountNumber.length > 4
                                ? account.accountNumber.substring(account.accountNumber.length - 4)
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
                                '••••$lastDigits',
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
                                setState(() => _showAccountPopup = false);
                              },
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            // Add Options Popup
            if (_showAddOptionsPopup)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => setState(() => _showAddOptionsPopup = false),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    alignment: Alignment.center,
                    child: Container(
                      width: 280,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Popup header
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Add New',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Add options list
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              children: [
                                _buildAddOptionItem(
                                  icon: Icons.account_balance_wallet,
                                  title: 'Create Wallet Instantly',
                                  subtitle: 'Instant digital wallet creation',
                                  color: AppColors.success,
                                  onTap: () => _handleAddOption('Create Wallet Instantly', dashboardVM),
                                ),
                                _buildAddOptionItem(
                                  icon: Icons.account_balance,
                                  title: 'Create Account',
                                  subtitle: 'Open a new bank account',
                                  color: AppColors.primary,
                                  onTap: () => _handleAddOption('Create Account', dashboardVM),
                                ),
                                _buildAddOptionItem(
                                  icon: Icons.link,
                                  title: 'Link Existing Account',
                                  subtitle: 'Connect your existing bank account',
                                  color: AppColors.danger,
                                  onTap: () => _handleAddOption('Link Existing Account', dashboardVM),
                                ),
                              ],
                            ),
                          ),

                          // Close button
                          Container(
                            padding: const EdgeInsets.all(12),
                            child: TextButton(
                              onPressed: () => setState(() => _showAddOptionsPopup = false),
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.text.withOpacity(0.6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}