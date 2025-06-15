import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OmdbService {
  static final String _apiKey = dotenv.env['OMDB_API_KEY'] ?? '';

  static const String _baseUrl = 'https://www.omdbapi.com/';

  static Future<Map<String, dynamic>?> fetchMovieDetails(String title) async {
    final url = Uri.parse('$_baseUrl?apikey=$_apiKey&t=$title&plot=full');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['Response'] == 'True') {
          return data;
        }
      }
    } catch (e) {
      print('Error fetching movie details: $e');
    }
    return null; // Return null if no data is found
  }

  static Future<List<String>> fetchMoviePosters(List<String> titles) async {
    List<String> posters = [];
    for (String title in titles) {
      final data = await fetchMovieDetails(title);
      if (data != null && data['Poster'] != 'N/A') {
        posters.add(data['Poster']);
      } else {
        posters.add(''); // Placeholder for missing posters
      }
    }
    return posters;
  }

  static Future<List<Map<String, String>>> fetchMovies(
      List<String> titles) async {
    List<Map<String, String>> movies = [];
    for (var title in titles) {
      final url = Uri.parse('$_baseUrl?apikey=$_apiKey&t=$title&plot=full');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        movies.add({
          'title': data['Title'] ?? 'Unknown',
          'year': data['Year'] ?? 'N/A',
          'poster': data['Poster'] ?? '',
          'plot': data['Plot'] ?? 'Plot not available',
          'director': data['Director'] ?? 'Director not available',
          'runtime': data['Runtime'] ?? 'N/A',
        });
      }
    }
    return movies;
  }
}
