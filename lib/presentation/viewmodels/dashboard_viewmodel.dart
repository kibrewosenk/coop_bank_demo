import 'package:flutter/material.dart';
import '../../../data/models/account_model.dart';

class DashboardViewModel extends ChangeNotifier {
  List<AccountModel> accounts = [
    // AccountModel(
    //   id: '1',
    //   accountType: 'Primary Account',
    //   accountNumber: '1234',
    //   balance: 12345.67,
    //   currency: 'ETB',
    //
    // ),
    // AccountModel(
    //   id: '2',
    //   accountType: 'Savings Account',
    //   accountNumber: '5678',
    //   balance: 5000.00,
    //   currency: 'ETB',
    // ),
    // AccountModel(
    //   id: '3',
    //   accountType: 'Investment Account',
    //   accountNumber: '9012',
    //   balance: 25000.00,
    //   currency: 'ETB',
    //
    // ),
  ];

  String _currentAccountId = '1';
  bool _isBalanceVisible = true;

  AccountModel? get currentAccount {
    return accounts.firstWhere((account) => account.id == _currentAccountId);
  }

  bool get isBalanceVisible => _isBalanceVisible;

  double get totalBalance {
    return accounts.fold(0, (sum, account) => sum + account.balance);
  }

  void switchAccount(String accountId) {
    _currentAccountId = accountId;
    notifyListeners();
  }

  void toggleBalanceVisibility() {
    _isBalanceVisible = !_isBalanceVisible;
    notifyListeners();
  }
}