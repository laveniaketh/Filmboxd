import 'package:filmboxd/models/review_model.dart';
import 'package:flutter/material.dart';
import '../services/omdb_service.dart';

class ReviewPostWidget extends StatelessWidget {
  final ReviewPost review;

  const ReviewPostWidget({super.key, required this.review});

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
          // Poster Placeholder
          Container(
            width: 60,
            height: 90,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(review.moviePoster),
                fit: BoxFit.cover,
              ),
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          SizedBox(width: 16),
          // Details Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Year
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: review.movieTitle,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Color(0xfF1F1516),
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: ' ${review.yearOfRelease}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          review.username,
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
                          backgroundImage: NetworkImage(review.profileImage),
                          backgroundColor: Colors.grey[300],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                // Rating (Placeholder Stars)
                Row(
                  children: List.generate(
                    5,
                    (index) => ImageIcon(
                      AssetImage('images/homepage/star.png'),
                      color: Color(0xffF3D72E),
                      size: 13,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                // Review Text
                Text(
                  review.textPost,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Color(0xfF1F1516),
                  ),
                ),
                SizedBox(height: 12),
                // Likes, Comments, Category
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
                          '${review.numberOfLikes}',
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
                          '${review.numberOfComments}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Color(0xfF1F1516),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xfff8db2b2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Film >',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.white,
                            ),
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
