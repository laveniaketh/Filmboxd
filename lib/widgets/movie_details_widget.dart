import 'package:flutter/material.dart';

class MovieDetailsWidget extends StatelessWidget {
  final Map<String, dynamic> movieData;

  const MovieDetailsWidget({required this.movieData, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (movieData['Poster'] != 'N/A')
            Center(
              child: Image.network(
                movieData['Poster'],
                height: 200,
              ),
            ),
          const SizedBox(height: 16),
          Text(
            movieData['Title'] ?? 'N/A',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Year: ${movieData['Year'] ?? 'N/A'}'),
          const SizedBox(height: 8),
          Text('Director: ${movieData['Director'] ?? 'N/A'}'),
          const SizedBox(height: 8),
          Text('Plot: ${movieData['Plot'] ?? 'N/A'}'),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.yellow),
              const SizedBox(width: 4),
              Text(movieData['imdbRating'] ?? 'N/A'),
            ],
          ),
        ],
      ),
    );
  }
}
