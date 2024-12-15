import 'package:filmboxd/pages/home_page.dart';
import 'package:filmboxd/pages/notification_page.dart';
import 'package:filmboxd/pages/profile_page.dart';
import 'package:filmboxd/pages/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  RootPage({super.key});

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  // final user = FirebaseAuth.instance.currentUser!;

  int _selectedIndex = 0;

  final List<Color> selectedTabColors = [
    Color(0xfF8DB2B2),
    Color(0xfFF3D72E),
    Color(0xfffB85D48),
  ];

  // Method to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // List of widgets for each tab's content
  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    NotificationPage(),
    ProfilePage(),
  ];

//sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.all(16.0), // Spacing around the bottom nav bar
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xfF1F1516),
            borderRadius: BorderRadius.circular(50), // Circular border
          ),
          child: BottomNavigationBar(
            backgroundColor:
                Colors.transparent, // To maintain the container's color
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            showSelectedLabels: false, // Hide labels for a cleaner look
            showUnselectedLabels: false, // Hide unselected labels
            selectedItemColor: Colors.white, // Selected icon color
            unselectedItemColor:
                Colors.white.withOpacity(0.5), // Unselected icon color
            elevation: 0,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Image.asset(
                  'images/homepage/home.png',
                  height: 31,
                  width: 31,
                ),
                activeIcon: Image.asset(
                  'images/homepage/home-selected.png',
                  height: 31,
                  width: 31,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'images/homepage/search.png',
                  height: 31,
                  width: 31,
                ),
                activeIcon: Image.asset(
                  'images/homepage/search-selected.png',
                  height: 31,
                  width: 31,
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'images/homepage/notification.png',
                  height: 31,
                  width: 31,
                ),
                activeIcon: Image.asset(
                  'images/homepage/notification-selected.png',
                  height: 31,
                  width: 31,
                ),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'images/homepage/profile.png',
                  height: 31,
                  width: 31,
                ),
                activeIcon: Image.asset(
                  'images/homepage/profile-selected.png',
                  height: 31,
                  width: 31,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
