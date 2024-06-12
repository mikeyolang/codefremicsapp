import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> saveUserDetails({
    required String firstName,
    required String lastName,
    required String email,
    required String currency,
  }) async {
    await _secureStorage.write(key: 'first_name', value: firstName);
    await _secureStorage.write(key: 'last_name', value: lastName);
    await _secureStorage.write(key: 'email', value: email);
    await _secureStorage.write(key: 'currency', value: currency);
  }
}

// retrieving the usr Details

class ProfileService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<Map<String, String?>> getUserDetails() async {
    String? firstName = await _secureStorage.read(key: 'first_name');
    String? lastName = await _secureStorage.read(key: 'last_name');
    String? email = await _secureStorage.read(key: 'email');
    String? currency = await _secureStorage.read(key: 'currency');

    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'currency': currency,
    };
  }
}
