import 'package:flutter/material.dart';
import '../services/omdb_service.dart';
import '../widgets/movie_details_widget.dart';

class MovieDetailsScreen extends StatefulWidget {
  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  Map<String, dynamic>? movieData;
  bool isLoading = false;

  Future<void> fetchMovie(String title) async {
    setState(() {
      isLoading = true;
    });

    final data = await OmdbService.fetchMovieDetails(title);
    setState(() {
      movieData = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMovie("Mysterious Skin"); // Default movie title
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : movieData != null
              ? MovieDetailsWidget(movieData: movieData!)
              : const Center(
                  child: Text('Movie not found!'),
                ),
    );
  }
}
