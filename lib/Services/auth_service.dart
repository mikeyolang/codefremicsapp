import 'dart:convert';
import 'package:codefremicsapp/Services/profile_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginService {
  final String _baseUrl =
      'https://stemprotocol.codefremics.com/api/v2/users/login';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final UserService _userService = UserService();

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 200) {
        await _secureStorage.write(
            key: 'access_token', value: responseData['access_token']);
        await _secureStorage.write(
            key: 'refresh_token', value: responseData['refresh_token']);
        await _userService.saveUserDetails(
          firstName: responseData['firstName'],
          lastName: responseData['lastName'],
          email: username,
          currency: responseData['currency'],
        );
        return {'success': true, 'message': 'Login successful'};
      } else {
        return {'success': false, 'message': 'Invalid login credentials'};
      }
    } else {
      return {'success': false, 'message': 'Failed to log in'};
    }
  }
   Future<void> logout() async {
    await _secureStorage.delete(key: 'access_token');
    await _secureStorage.delete(key: 'refresh_token');
  }
}
