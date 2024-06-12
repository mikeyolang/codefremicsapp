import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomerService {
  final String _baseUrl =
      'https://stemprotocol.codefremics.com/api/v2/customers/get-merchant-customers/1';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> fetchCustomerList() async {
    String? accessToken = await _secureStorage.read(key: 'access_token');

    if (accessToken == null) {
      return {
        'success': false,
        'message': 'Access token not found',
      };
    }

    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 200) {
        List<Map<String, String>> customers = [];
        for (var customer in responseData['response']) {
          customers.add({
            'first_name': customer['first_name'],
            'email': customer['email'],
            'customer_id': customer['customer_id'],
          });
        }
        return {
          'success': true,
          'description': responseData['description'],
          'customers': customers,
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to fetch customer list',
        };
      }
    } else {
      return {
        'success': false,
        'message': 'Failed to fetch customer list',
      };
    }
  }
}


