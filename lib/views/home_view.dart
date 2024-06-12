import 'package:codefremicsapp/constants/constants.dart';
import 'package:codefremicsapp/views/customer_creation_screen.dart';
import 'package:codefremicsapp/views/customer_list_view.dart';
import 'package:codefremicsapp/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Dialogs/logout_dialog.dart';
import '../enums/menu_action.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({
    super.key,
    required this.firstName,
    required this.userEmail,
    required this.secondName,
  });
  final String firstName;
  final String userEmail;
  final String secondName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              // color: CustomColors.secondaryColor
              ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(
                    top: 15,
                    left: 15,
                    right: 15,
                    bottom: 4,
                  ),
                  decoration: const BoxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: const BoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const CircleAvatar(
                                radius: 30,
                                child: Icon(
                                  Icons.person_outlined,
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        firstName,
                                        style: TextStyle(
                                          color: CustomColors.textColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        secondName,
                                        style: TextStyle(
                                          color: CustomColors.textColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    userEmail,
                                    style: TextStyle(
                                      color: CustomColors.textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton(
                          iconColor: CustomColors.textColor,
                          color: CustomColors.textColor,
                          onSelected: (value) async {
                            switch (value) {
                              case MenuAction.logout:
                                final shouldLogout =
                                    await showLogOutDialog(context);
                                if (shouldLogout) {
                                  SharedPreferences sp =
                                      await SharedPreferences.getInstance();

                                  sp.clear();
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()),
                                  );
                                }
                            }
                          },
                          itemBuilder: (context) {
                            return [
                              const PopupMenuItem<MenuAction>(
                                value: MenuAction.logout,
                                child: Text("Log Out"),
                              ),
                            ];
                          }),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .56,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Image.asset(
                    "assets/image.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 55,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue,
                  ),
                  child: TextButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CustomerCreationScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Create Customer",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 55,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue,
                  ),
                  child: TextButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CustomerListView(),
                        ),
                      );
                    },
                    child: const Text(
                      "Customer List",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
