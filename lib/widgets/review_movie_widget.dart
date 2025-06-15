import 'package:flutter/material.dart';

class ReviewMovieWidget extends StatelessWidget {
  final String username;
  final String reviewText;
  final int likes;
  final int comments;
  final int starRating;

  const ReviewMovieWidget({
    super.key,
    required this.username,
    required this.reviewText,
    required this.likes,
    required this.comments,
    required this.starRating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // color: const Color(0xFF1F1516), // Dark background color
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          // Profile Picture
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey[400], // Placeholder background
            child: const Icon(Icons.person, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username and Rating Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF1F1516),
                      ),
                    ),
                    Row(
                      children: List.generate(
                      5,
                      (index) => ImageIcon(
                        AssetImage('images/homepage/star.png'),
                        size: 10,
                        color: index < starRating ? Colors.yellow : Colors.grey,
                      ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Review Text
                Text(
                  reviewText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Color(0xFF1F1516),
                  ),
                ),
                const SizedBox(height: 8),
                // Likes and Comments Row
                Row(
                  children: [
                    Row(
                      children: [
                        ImageIcon(
                          AssetImage('images/homepage/heart.png'),
                          size: 16,
                          color: Color(0xfffb85d48),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          likes.toString(),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Color(0xFF1F1516),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        ImageIcon(
                          AssetImage('images/homepage/comment.png'),
                          size: 16,
                          color: Color(0xfF1F1516),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          comments.toString(),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Color(0xFF1F1516),
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
