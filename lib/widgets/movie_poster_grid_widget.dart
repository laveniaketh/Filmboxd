import 'package:filmboxd/services/omdb_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MoviePosterGridView extends StatelessWidget {
// Number of placeholder posters to display
  final String username;

  const MoviePosterGridView( {
    super.key,
    required this.username,
  });

  Future<List<String>> _fetchWatchlistMovieTitles() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('User Activities')
        .where('isWatchlist', isEqualTo: true)
        .where('username', isEqualTo: username)
        .get();

    return querySnapshot.docs
        .map((doc) => doc['movieTitle'] as String)
        .toList();
  }

  Future<List<String>> _fetchMoviePosters(List<String> movieTitles) async {
    final posters = <String>[];
    for (final title in movieTitles) {
      final fetchedData = await OmdbService.fetchMovieDetails(title);
      if (fetchedData != null && fetchedData['Poster'] != null) {
        posters.add(fetchedData['Poster'] as String);
      }
    }
    return posters;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _fetchWatchlistMovieTitles()
          .then((titles) => _fetchMoviePosters(titles)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No movies found in watchlist.'));
        } else {
          final posters = snapshot.data!;
          return GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // 4 items in a row
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: posters.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(posters[index]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          );
        }
      },
    );
  }
}
