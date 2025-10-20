class AccountModel {
  final String id;
  final String accountType;
  final String accountNumber;
  final double balance;
  final String currency;

  AccountModel({
    required this.id,
    required this.accountType,
    required this.accountNumber,
    required this.balance,
    this.currency = 'USD',
  });
}