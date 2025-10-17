class UserModel {
  final String phone;
  final String nid;
  final String pin;
  final String motherName;
  final bool isActivated;
  final bool useBiometric;

  UserModel({
    required this.phone,
    required this.nid,
    required this.pin,
    required this.motherName,
    this.isActivated = false,
    this.useBiometric = false,
  });
}