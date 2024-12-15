import 'package:flutter/material.dart';
import '../services/omdb_service.dart';

class ReviewPost {
  final String movieTitle;
  final String yearOfRelease;
  final String moviePoster;
  final double starRating;
  final String textPost;
  final String username;
  final String profileImage;
  final int numberOfLikes;
  final int numberOfComments;

  ReviewPost({
    required this.movieTitle,
    required this.yearOfRelease,
    required this.moviePoster,
    required this.starRating,
    required this.textPost,
    required this.username,
    required this.profileImage,
    required this.numberOfLikes,
    required this.numberOfComments,
  });

  static Future<ReviewPost> createFromTitle({
    required String movieTitle,
    required double starRating,
    required String textPost,
    required String username,
    required String profileImage,
    required int numberOfLikes,
    required int numberOfComments,
  }) async {
    final movieDetails = await OmdbService.fetchMovieDetails(movieTitle);

    return ReviewPost(
      movieTitle: movieTitle,
      yearOfRelease: movieDetails?['Year'] ?? 'N/A',
      moviePoster: movieDetails?['Poster'] ?? '',
      starRating: starRating,
      textPost: textPost,
      username: username,
      profileImage: profileImage,
      numberOfLikes: numberOfLikes,
      numberOfComments: numberOfComments,
    );
  }
}






// class ReviewModel {
//   final String title;
//   final String year;
//   final String username;
//   final String profileImage;
//   final int rating;
//   final String reviewText;
//   final int likes;
//   final int comments;
//   final String category;

//   ReviewModel({
//     required this.title,
//     required this.year,
//     required this.username,
//     required this.profileImage,
//     required this.rating,
//     required this.reviewText,
//     required this.likes,
//     required this.comments,
//     required this.category,
//   });
// }

// final List<ReviewModel> reviews = [
//     ReviewModel(
//       title: 'Moana 2',
//       year: '2024',
//       username: 'prim',
//       profileImage: 'assets/images/user_placeholder.png', // Replace with your asset
//       rating: 3,
//       reviewText: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
//       likes: 98,
//       comments: 0,
//       category: 'Film',
//     ),
//     // Add more ReviewModel instances here for iteration
//   ];