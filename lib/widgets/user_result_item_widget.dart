import 'package:flutter/material.dart';

class UserResultItemWidget extends StatelessWidget {
  const UserResultItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Circular Profile Image
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey[300],
            // backgroundImage: AssetImage(profileImagePath),
          ),
          SizedBox(width: 10),
          // User Name and Tag
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'janna',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              Text(
                'meeviester',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          Spacer(),
          // Add Button (Plus Icon)
            IconButton(
            icon: Image.asset(
              'images/searchpage/add.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              // Add user to friends list
            },
          ),
        ],
      ),
    );
  }
}
