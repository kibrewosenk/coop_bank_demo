import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/app_drawer.dart';
import '../../viewmodels/dashboard_viewmodel.dart';
import 'package:provider/provider.dart';
import 'tabs/home_tab.dart';
import 'tabs/transfers_tab.dart';
import 'tabs/services_tab.dart';
import 'tabs/profile_tab.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeTab(),
    const TransfersTab(),
    const ServicesTab(),
    const ProfileTab(),
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
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
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
      drawer: const AppDrawer(),
      body: WillPopScope(
        onWillPop: () async {
          // Prevent back button from logging out
          return false;
        },
        child: _pages[_selectedIndex],
      ),
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