import 'package:filmboxd/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import '../services/omdb_service.dart';

class MoviePosterScrollWidget extends StatefulWidget {
  final List<String> movieTitles;
  final double posterWidth;
  final double posterHeight;

  const MoviePosterScrollWidget({
    required this.movieTitles,
    required  this.posterWidth,
    required  this.posterHeight,
    super.key,
  });

  @override
  _MoviePosterScrollWidgetState createState() =>
      _MoviePosterScrollWidgetState();
}

class _MoviePosterScrollWidgetState extends State<MoviePosterScrollWidget> {
  List<Map<String, String>> movieData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMovieData();
  }

  Future<void> fetchMovieData() async {
    final fetchedData = await OmdbService.fetchMovies(widget.movieTitles);
    setState(() {
      movieData = fetchedData;
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
              children: List.generate(movieData.length, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MovieDetailPage(
                          posterUrl: movieData[index]['poster'] ?? '',
                          title: movieData[index]['title'] ?? 'Unknown',
                          year: movieData[index]['year'] ?? 'N/A',
                          plot: movieData[index]['plot'] ?? 'Plot not available',
                          director: movieData[index]['director'] ?? 'Director not available',
                          runtime: movieData[index]['runtime'] ?? 'N/A',
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: movieData[index]['poster']?.isNotEmpty == true
                        ? Container(
                            width: widget.posterWidth,
                            height: widget.posterHeight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image:
                                    NetworkImage(movieData[index]['poster']!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            width: widget.posterWidth,
                            height: widget.posterHeight,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.image, size: 40),
                          ),
                  ),
                );
              }),
            ),
          );
  }
}
