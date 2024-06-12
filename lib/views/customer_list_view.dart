// ignore_for_file: library_private_types_in_public_api

import 'package:codefremicsapp/Widgets/nav_roots.dart';
import 'package:codefremicsapp/constants/constants.dart';
import 'package:codefremicsapp/views/customer_details.dart';
import 'package:codefremicsapp/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Services/customer_list_service.dart';

class CustomerListView extends StatefulWidget {
  const CustomerListView({super.key});

  @override
  _CustomerListViewState createState() => _CustomerListViewState();
}

class _CustomerListViewState extends State<CustomerListView> {
  final CustomerService _customerService = CustomerService();
  List<Map<String, dynamic>> _allUsers = [];
  List<Map<String, dynamic>> _foundUsers = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchCustomers();
  }

  Future<void> _fetchCustomers() async {
    final result = await _customerService.fetchCustomerList();
    if (result['success']) {
      setState(() {
        _allUsers = result['customers'].map<Map<String, dynamic>>((customer) {
          return {
            "id": customer['customer_id'],
            "name": customer['first_name'],
            "email": customer['email'],
          };
        }).toList();
        _foundUsers = _allUsers;
        _isLoading = false;
      });
    } else {
      setState(() {
        _errorMessage = result['message'];
        _isLoading = false;
      });
    }
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user["email"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: CustomColors.primaryColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            IconButton(
              color: Colors.white,
              onPressed: () async {
                const FlutterSecureStorage secureStorage =
                    FlutterSecureStorage();
                String? firstName = await secureStorage.read(key: 'first_name');
                String? secondName = await secureStorage.read(key: 'last_name');
                String? userName = await secureStorage.read(key: 'email');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePageView(
                        firstName: firstName!,
                        secondName: secondName!,
                        userEmail: userName!,
                      );
                    },
                  ),
                );
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            Container(
              margin: const EdgeInsets.only(left: 7),
              child: Text(
                "Customers List",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.textColor),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey)),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search Here....",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                    : _errorMessage != null
                        ? Center(
                            child: Text(
                              _errorMessage!,
                              style: TextStyle(
                                  fontSize: 24, color: CustomColors.textColor),
                            ),
                          )
                        : _foundUsers.isNotEmpty
                            ? ListView.builder(
                                itemCount: _foundUsers.length,
                                itemBuilder: (context, index) => Card(
                                  key: ValueKey(_foundUsers[index]["id"]),
                                  color: Colors.blue,
                                  elevation: 2,
                                  margin: const EdgeInsets.all(7),
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    title: Text(
                                      _foundUsers[index]['name'],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      _foundUsers[index]["email"],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      print(_foundUsers[index]['id']);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CustomerDetailsView(
                                            customerId: _foundUsers[index]
                                                ['id'],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Text(
                                'No results found',
                                style: TextStyle(
                                    fontSize: 24,
                                    color: CustomColors.textColor),
                              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
