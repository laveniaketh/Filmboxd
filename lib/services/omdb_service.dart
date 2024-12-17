import 'dart:convert';
import 'package:http/http.dart' as http;

class OmdbService {
  static const String _apiKey = '6eeeb55e'; 

  static const String _baseUrl = 'https://www.omdbapi.com/';

  static Future<Map<String, dynamic>?> fetchMovieDetails(String title) async {
    final url = Uri.parse('$_baseUrl?apikey=$_apiKey&t=$title');
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

}
