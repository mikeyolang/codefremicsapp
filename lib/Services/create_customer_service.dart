import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomerCreateService {
  final String _baseUrl =
      'https://stemprotocol.codefremics.com/api/v2/customers/';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<String?> _getAccessToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  Future<Map<String, dynamic>> fetchCustomerDetails(String customerId) async {
    final accessToken = await _getAccessToken();
    if (accessToken == null) {
      return {
        'success': false,
        'message': 'No access token found',
      };
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/get-customer-details/$customerId'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      return {
        'success': true,
        'customer': responseData['response'],
      };
    } else {
      return {
        'success': false,
        'message': 'Failed to fetch customer details',
      };
    }
  }

  Future<Map<String, dynamic>> createCustomer({
    required String firstName,
    required String otherNames,
    required String gender,
    required String mobileNumber,
    required String email,
    required String description,
  }) async {
    final accessToken = await _getAccessToken();
    if (accessToken == null) {
      return {
        'success': false,
        'message': 'No access token found',
      };
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/create'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'first_name': firstName,
        'other_names': otherNames,
        'gender': gender,
        'mobile_number': mobileNumber,
        'email': email,
        'description': description,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      return {
        'success': true,
        'message': responseData['description'],
      };
    } else {
      return {
        'success': false,
        'message': 'Failed to create customer',
      };
    }
  }
}
