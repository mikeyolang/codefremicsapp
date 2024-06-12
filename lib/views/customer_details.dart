import 'package:flutter/material.dart';

import '../Services/customer_profile_service.dart';

class CustomerDetailsView extends StatefulWidget {
  final String customerId;

  const CustomerDetailsView({super.key, required this.customerId});

  @override
  _CustomerDetailsViewState createState() => _CustomerDetailsViewState();
}

class _CustomerDetailsViewState extends State<CustomerDetailsView> {
  final CustomerDetailsService _customerDetailsService =
      CustomerDetailsService();
  Map<String, dynamic>? _customerDetails;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchCustomerDetails();
  }

  Future<void> _fetchCustomerDetails() async {
    final result =
        await _customerDetailsService.fetchCustomerDetails(widget.customerId);
    if (result['success']) {
      setState(() {
        _customerDetails = result['customer'];
        _isLoading = false;
      });
    } else {
      setState(() {
        _errorMessage = result['message'];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Details"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage != null
                ? Center(
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(fontSize: 24, color: Colors.red),
                    ),
                  )
                : _customerDetails != null
                    ? Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.blue,
                                  child: Text(
                                    _customerDetails!['first_name'][0],
                                    style: const TextStyle(
                                      fontSize: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "First Name: ${_customerDetails!['first_name']} ",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Other Names: ${_customerDetails!['other_names']}",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Mobile Number: ${_customerDetails!['mobile']}",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Gender: ${_customerDetails!['gender']}",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Email: ${_customerDetails!['email']}",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const Text(
                        'No details found',
                        style: TextStyle(fontSize: 24),
                      ),
      ),
    );
  }
}
