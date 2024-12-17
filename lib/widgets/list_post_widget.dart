import 'package:flutter/material.dart';

class ListPostWidget extends StatelessWidget {
  const ListPostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // list title and desc
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "list title",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Color(0xfF1F1516),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "username",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Color(0xfF1F1516),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        CircleAvatar(
                          radius: 12,
                          // backgroundImage: NetworkImage(review.profileImage),
                          backgroundColor: Colors.grey[300],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),

                // small horizontal scrollable movie posters
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10, // Number of posters
                    itemBuilder: (context, index) {
                      return Container(
                        width: 40,
                        margin: EdgeInsets.only(right: 3),
                        decoration: BoxDecoration(
                          // image: DecorationImage(
                          //   image: AssetImage('images/homepage/poster1.jpg'),
                          //   fit: BoxFit.cover,
                          // ),
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5),
                        ),
                      );
                    },
                  ),
                ),

                // list desc
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minimsdfdsfdfdsfdsfdsf sdwa sd dfs ",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Color(0xfF1F1516),
                  ),
                ),
                SizedBox(height: 12),
                // Likes, Comments
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ImageIcon(
                          AssetImage('images/homepage/heart.png'),
                          color: Color(0xfffb85d48),
                          size: 24,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '10',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Color(0xfF1F1516),
                          ),
                        ),
                        SizedBox(width: 10),
                        ImageIcon(
                          AssetImage('images/homepage/comment.png'),
                          color: Color(0xfF1F1516),
                          size: 24,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '4',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Color(0xfF1F1516),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}