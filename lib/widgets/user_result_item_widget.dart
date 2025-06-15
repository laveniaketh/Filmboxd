import 'package:flutter/material.dart';

class UserResultItemWidget extends StatelessWidget {
  final String username;
  final String name;
  final String? profileImage;

  const UserResultItemWidget({
    super.key,
    required this.username,
    required this.name,
    this.profileImage,
  });

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
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey[300],
            backgroundImage: profileImage != null
                ? NetworkImage(profileImage!)
                : null,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              Text(
                username,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          Spacer(),
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
