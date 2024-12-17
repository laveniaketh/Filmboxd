import 'package:flutter/material.dart';

class MovieResultItemWidget extends StatelessWidget {
  const MovieResultItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        // color: Color(0xFFFFF4E0),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Poster Placeholder
          Container(
            width: 50,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[300], 
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          SizedBox(width: 16),
          // Movie Details
          Expanded(
            child: RichText(
              text: TextSpan(
                text: 'Mean Girls ', // Movie title
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: Color(0xFF1F1516),
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '2004, ', // Release year
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: Color(0xFF1F1516),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: 'directed by ', // Additional text
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: Color(0xFF1F1516),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: 'Mark Waters', // Director's name
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: Color(0xFF1F1516),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
