import '../models/user_model.dart';

final List<UserModel> dummyUsers = [
  UserModel(
    fullname: 'Kibrewosen',
    phone: '1234567890',
    nid: '123456',
    pin: '1234', // In real, hash this
    motherName: 'mother 1',
    isActivated: true,
    useBiometric: false,
  ),
  UserModel(
    fullname: 'Gutu',
    phone: '0927350623',
    nid: '123123',
    pin: '1234',
    motherName: 'allmother',
    isActivated: false,
    useBiometric: false,
  ),
  // Add more dummy users here if needed
];
