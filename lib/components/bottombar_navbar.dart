import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Spacing around the bottom nav bar
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xfF1F1516),
          borderRadius: BorderRadius.circular(50), // Circular border
        ),
        child: BottomNavigationBar(
          backgroundColor:
              Colors.transparent, // To maintain the container's color
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: onTap,
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
    );
  }
}
