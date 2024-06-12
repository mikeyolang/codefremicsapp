import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomerDetailsService {
  final String _baseUrl =
      'https://stemprotocol.codefremics.com/api/v2/customers/get-customer-details/';
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
      Uri.parse('$_baseUrl$customerId'),
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
}
