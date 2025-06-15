import 'package:filmboxd/components/bottombar_navbar.dart';
import 'package:filmboxd/pages/home_page.dart';
import 'package:filmboxd/pages/notification_page.dart';
import 'package:filmboxd/pages/profile_page.dart';
import 'package:filmboxd/pages/search_page.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    NotificationPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex, 
        onTap: _onItemTapped,
      ),
    );
  }
}
