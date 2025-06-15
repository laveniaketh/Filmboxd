import 'package:filmboxd/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';

class MovieResultItemWidget extends StatelessWidget {
  final String title;
  final String year;
  final String director;
  final String posterUrl;
  final String runtime;
  final String plot;

  const MovieResultItemWidget({
    super.key,
    required this.title,
    required this.year,
    required this.director,
    required this.posterUrl,
    required this.runtime,
    required this.plot,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MovieDetailPage(
              posterUrl: posterUrl,
              title: title,
              year: year,
              plot: plot,
              director: director,
              runtime: runtime,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Poster
                Container(
                  width: 50,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: posterUrl.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(posterUrl),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: Colors.grey[300],
                  ),
                  child: posterUrl.isEmpty
                      ? Center(
                          child: Icon(
                            Icons.image,
                            color: Colors.grey[600],
                          ),
                        )
                      : null,
                ),
                SizedBox(width: 16),
                // Movie Details
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: '$title ', // Movie title
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Color(0xFF1F1516),
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: '$year, ', // Release year
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
                          text: director, // Director's name
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
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
          ],
        ),
      ),
    );
  }
}
