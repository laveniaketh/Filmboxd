import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmboxd/pages/review_post_detail_page.dart';
import 'package:flutter/material.dart';
import '../services/omdb_service.dart';

class ReviewPostWidget extends StatelessWidget {
  final String movieTitle;
  final int starRating;
  final String reviewText;
  final String username;
  final bool isLikeSelected;
  final String datePosted;

  const ReviewPostWidget({
    super.key,
    required this.movieTitle,
    required this.starRating,
    required this.reviewText,
    required this.username, 
    required this.isLikeSelected, 
    required this.datePosted,
  });

  Future<Map<String, String>> fetchMovieDetails(String title) async {
    final movieDetails = await OmdbService.fetchMovieDetails(title);
    return {
      'yearOfRelease': movieDetails?['Year'] ?? 'N/A',
      'moviePoster': movieDetails?['Poster'] ?? '',
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: fetchMovieDetails(movieTitle),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching movie details'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No data available'));
        }

        final movieDetails = snapshot.data!;
        final yearOfRelease = movieDetails['yearOfRelease']!;
        final moviePoster = movieDetails['moviePoster']!;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReviewPostDetailPage(
                  movieTitle: movieTitle,
                  year: yearOfRelease,
                  posterUrl: moviePoster,
                  starRating: starRating,
                  reviewText: reviewText,
                  username: username,
                  isLikeSelected: isLikeSelected,
                  datePosted: datePosted,
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Poster
                Container(
                  width: 60,
                  height: 90,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(moviePoster),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(width: 16),
                // Movie Details Section
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
                              text: '$movieTitle ',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                color: Color(0xfF1F1516),
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: yearOfRelease,
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
                                username,
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
                                child: Icon(Icons.person,
                                    size: 24, color: Colors.white),
                                backgroundColor: Colors.grey[300],
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Rating
                      Row(
                        children: List.generate(
                          starRating,
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
                        reviewText,
                        maxLines: 5,
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
                                AssetImage('images/homepage/heart-outline.png'),
                                color: Color(0xfffb85d48),
                                size: 24,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '0',
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
                                '1',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: Color(0xfF1F1516),
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
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
          ),
        );
      },
    );
  }
}
