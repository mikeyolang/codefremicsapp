// Name: Michael Olang
// Email: olangmichael@gmail.com
// phone: +254768241008
// github: @mikeyolang
import 'package:codefremicsapp/views/customer_list_view.dart';
import 'package:codefremicsapp/views/home_view.dart';
import 'package:codefremicsapp/views/profile.dart';
import 'package:flutter/material.dart';

class NavBarRoots extends StatefulWidget {
  const NavBarRoots({super.key});

  @override
  State<NavBarRoots> createState() => _NavBarRootsState();
}

class _NavBarRootsState extends State<NavBarRoots> {
  int _selectIndex = 0;
  final _screens = [
    //Home Screen
    // const HomePageView(),
    //  Customer List
    const CustomerListView(),
    //  Profile Screen
    const UserProfile(),
    
   
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectIndex],
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          currentIndex: _selectIndex,
          onTap: (index) {
            setState(() {
              _selectIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              label: "Customer Lists",
            ),

            // BottomNavigationBarItem(Icon(Icons.people), label: "Community")
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
