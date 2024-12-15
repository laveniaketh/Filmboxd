import 'package:flutter/material.dart';

class MoviePosterGridView extends StatelessWidget {
  final int posterCount; // Number of placeholder posters to display

  const MoviePosterGridView({this.posterCount = 8}); 

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 4 items in a row
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: posterCount,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[300], 
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );
  }
}