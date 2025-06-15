import 'package:flutter/material.dart';

class NotificationItemWidget extends StatelessWidget {
  final String activityText;
  final String movieName;

  const NotificationItemWidget({
    super.key,
    required this.activityText,
    required this.movieName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Circular Profile Image
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[300],
            // backgroundImage: AssetImage(profileImagePath),
          ),
          SizedBox(width: 10),
          // User Name and Tag
          Text(
            activityText,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          Text(
            ' $movieName',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Text(
            '1hr',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
