// Name: Michael Olang
// Email: olangmichael@gmail.com
// phone: +254768241008
// github: @mikeyolang

import 'dart:async';

import 'package:codefremicsapp/Dialogs/error_dialog.dart';
import 'package:codefremicsapp/Services/auth_service.dart';
import 'package:codefremicsapp/Widgets/nav_roots.dart';
import 'package:codefremicsapp/constants/constants.dart';
import 'package:codefremicsapp/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isVisible = false;

  bool isLoginTrue = false;

  final formKey = GlobalKey<FormState>();
  void isLogin() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? firstName = await secureStorage.read(key: 'first_name');
    String? secondName = await secureStorage.read(key: 'last_name');
    String? userName = await secureStorage.read(key: 'email');
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool? isLogin = sp.getBool("isLogin") ?? false;
    if (isLogin) {
      Timer(const Duration(seconds: 0), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePageView(
              firstName: firstName!,
              secondName: secondName!,
              userEmail: userName!,
            ),
          ),
        );
      });
    } else {
      Timer(const Duration(seconds: 10), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: CustomColors.primaryColor),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              //We put all our textfield to a form to be controlled and not allow as empty
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                      "Welcome back !",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.textColor),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      "assets/image.png",
                      width: 210,
                    ),

                    const SizedBox(height: 15),
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: CustomColors.textColor,
                        border: Border.all(color: Colors.black.withOpacity(.2)),
                      ),
                      child: TextFormField(
                       
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Username or Email number is required is required";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          icon: Icon(Icons.email),
                          border: InputBorder.none,
                          hintText: "Enter Username or Email",
                        ),
                      ),
                    ),

                    //Password field
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black.withOpacity(.2),
                        ),
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password is required";
                          }
                          return null;
                        },
                        obscureText: !isVisible,
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          icon: const Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: "Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              //In here we will create a click to show and hide the password a toggle button
                              setState(() {
                                //toggle button
                                isVisible = !isVisible;
                              });
                            },
                            icon: Icon(isVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                    //Login button
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue,
                      ),
                      child: TextButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final email = emailController.text.toString();
                            final password = passwordController.text.toString();
                            final loginService = LoginService();
                            const FlutterSecureStorage secureStorage =
                                FlutterSecureStorage();
                            String? firstName =
                                await secureStorage.read(key: 'first_name');
                            String? secondName =
                                await secureStorage.read(key: 'last_name');
                            String? userName =
                                await secureStorage.read(key: 'email');
                            Map<String, dynamic> responseResult =
                                await loginService.login(
                              email,
                              password,
                            );

                            bool isSuccess = responseResult['success'];
                            if (isSuccess) {
                              SharedPreferences sp =
                                  await SharedPreferences.getInstance();
                              sp.setString("email", email);
                              sp.setBool("isLogin", true);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePageView(
                                    firstName: firstName!,
                                    userEmail: userName!,
                                    secondName: secondName!,
                                  ),
                                ),
                              );
                            } else {
                              showErrorDialog(
                                  context, responseResult['message']);
                            }
                          }
                        },
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    //Sign up button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(color: CustomColors.textColor),
                        ),
                        TextButton(
                          onPressed: () {
                            //Navigate to sign up
                          },
                          child: const Text(
                            "SIGN UP",
                            style: TextStyle(
                                color: Color.fromARGB(255, 7, 117, 206)),
                          ),
                        )
                      ],
                    ),

                    // We will disable this message in default, when user and pass is incorrect we will trigger this message to user
                    isLoginTrue
                        ? const Text(
                            "Phone or passowrd is incorrect",
                            style: TextStyle(color: Colors.red),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
