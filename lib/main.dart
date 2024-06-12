import 'package:codefremicsapp/views/customer_creation_screen.dart';
import 'package:codefremicsapp/views/customer_details.dart';
import 'package:codefremicsapp/views/customer_list_view.dart';
import 'package:codefremicsapp/views/home_view.dart';
import 'package:codefremicsapp/views/login_view.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: LoginScreen(),
    );
  }
}
