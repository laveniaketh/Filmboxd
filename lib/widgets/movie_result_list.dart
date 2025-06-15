import 'package:filmboxd/widgets/movie_result_item_widget.dart';
import 'package:flutter/material.dart';

class MovieResultList extends StatefulWidget {
  static final _resultsNotifier = ValueNotifier<List<Map<String, String>>>([]);

  const MovieResultList({super.key});

  static void updateResults(List<Map<String, String>> results) {
    _resultsNotifier.value = results;
  }

  @override
  State<MovieResultList> createState() => _MovieResultListState();
}

class _MovieResultListState extends State<MovieResultList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, String>>>(
      valueListenable: MovieResultList._resultsNotifier,
      builder: (context, results, _) {
        if (results.isEmpty) {
            return const Center(
            child: Text(
              'No results found.',
              style: TextStyle(
              fontSize: 15,
              fontFamily: 'Poppins',
              color: Colors.grey,
              ),
            ),
            );
        }
        return Column(
            children: results
              .map((movie) => MovieResultItemWidget(
                title: movie['title'] ?? '',
                year: movie['year'] ?? '',
                director: movie['director'] ?? '',
                posterUrl: movie['poster'] ?? '',
                runtime: movie['runtime'] ?? '',
                plot: movie['plot'] ?? '',
                ))
              .toList(),
          );
      },
    );
  }
}
