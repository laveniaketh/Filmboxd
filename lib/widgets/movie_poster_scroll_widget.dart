import 'package:flutter/material.dart';
import '../services/omdb_service.dart';

class MoviePosterScrollWidget extends StatefulWidget {
  final List<String> movieTitles; // Titles for fetching posters

  const MoviePosterScrollWidget({
    required this.movieTitles,
    super.key,
  });

  @override
  _MoviePosterScrollWidgetState createState() =>
      _MoviePosterScrollWidgetState();
}

class _MoviePosterScrollWidgetState extends State<MoviePosterScrollWidget> {
  List<String> posters = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMoviePosters();
  }

  Future<void> fetchMoviePosters() async {
    final fetchedPosters =
        await OmdbService.fetchMoviePosters(widget.movieTitles);
    setState(() {
      posters = fetchedPosters;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(posters.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: posters[index].isNotEmpty
                      ? Container(
                          width: 100,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(posters[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          width: 100,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[300], // Placeholder color
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.image, size: 40),
                        ),
                );
              }),
            ),
          );
  }
}
