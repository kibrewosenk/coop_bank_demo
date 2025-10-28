import '../models/nid_model.dart';

final Map<String, NidModel> dummyNidData = {
  '123456': NidModel(
    fullName: 'Kibrewosen kerie',
    gender: 'Male',
    dob: '1992-01-01',
    photoUrl: 'assets/images/user_placeholder.png', // Dummy photo
    phoneNumber: '1234567890',
    address: '123 Main St',
  ),
  // ignore: equal_keys_in_map
  '123456789013': NidModel(
    fullName: 'Gutu Rare',
    gender: 'Male',
    dob: '1992-01-01',
    photoUrl: 'assets/images/user_placeholder.png', // Dummy photo
    phoneNumber: '1234567891',
    address: '123 Main St',
  ),
  // Add more dummy NIDs
};