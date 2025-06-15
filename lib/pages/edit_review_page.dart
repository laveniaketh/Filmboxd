import 'package:filmboxd/services/auth_service.dart';
import 'package:filmboxd/services/omdb_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditReviewPage extends StatefulWidget {
  final String posterUrl;
  final String movieTitle;
  final String year;
  final int starRating;
  final String reviewText;
  final bool isLikeSelected;
  final String datePosted;
  final String username;

  const EditReviewPage({
    required this.posterUrl,
    required this.movieTitle,
    required this.year,
    required this.starRating,
    required this.reviewText,
    required this.isLikeSelected,
    required this.datePosted,
    required this.username,
    super.key,
  });

  @override
  _EditReviewPageState createState() => _EditReviewPageState();
}


void updateReviewToDatabase(String movieTitle, String username, String datePosted,
  bool isLikedSelected, String review, int starRating, BuildContext context) {
  FirebaseFirestore.instance
    .collection('User Reviews')
    .where('movieTitle', isEqualTo: movieTitle)
    .where('username', isEqualTo: username)
    .get()
    .then((querySnapshot) {
  if (querySnapshot.docs.isNotEmpty) {
    querySnapshot.docs.first.reference.update({
    'isLiked': isLikedSelected,
    'review': review,
    'starRating': starRating,
    }).then((value) {
    print("Review Updated");

    ScaffoldMessenger.of(context).showSnackBar(
          
          SnackBar(
            content: Text(
              'Review updated successfully',
              style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
              ),
            ),
            backgroundColor: Color(0xfF1F1516),
          ),
        );

    Navigator.pop(context);
    Navigator.pop(context);
    }).catchError((error) {
    print("Failed to update review: $error");
    });
  } else {
    print("No matching review found.");
  }
  }).catchError((error) {
  print("Failed to find review: $error");
  });
}

class _EditReviewPageState extends State<EditReviewPage> {
  final reviewController = TextEditingController();
  int starRating = 0;
  late bool isLikeSelected; // Declare as late to initialize in initState

  @override
  void initState() {
    super.initState();
    isLikeSelected = widget.isLikeSelected; // Initialize from widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xfF1F1516),
        title: const Text(
          'I Watched...',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Image.asset(
            'images/profilepage/previous-light.png',
            color: const Color(0xfFFDEED4),
            width: 24,
            height: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'images/profilepage/save-light.png',
              color: const Color(0xfFFDEED4),
              width: 24,
              height: 24,
            ),
            onPressed: () async {
              final authService = AuthService();
              final user = await authService.getCurrentUser();

              if (user != null) {
                final userDoc = await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(user.email) // Using email as the document ID
                    .get();

                if (userDoc.exists) {
                  final userData = userDoc.data() as Map<String, dynamic>;
                  final username =
                    userData['username'] ?? 'Anonymous'; // Default to 'Anonymous' if no username

                  if (starRating == 0) {
                  starRating = widget.starRating;
                  }

                  updateReviewToDatabase(
                  widget.movieTitle,
                  username,
                  widget.datePosted,
                  isLikeSelected,
                  reviewController.text,
                  starRating,
                  context,
                  );
                } else {
                  // Handle case where the user document doesn't exist
                  print('User document not found.');
                }
              } else {
                // Handle case where the user is not logged in
                print('No user is currently logged in.');
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.posterUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.network(
                          widget.posterUrl,
                          width: 80,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        width: 132,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: const Icon(Icons.image, size: 80),
                      ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 200,
                        child: Text(
                          widget.movieTitle,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F1516),
                          ),
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        ),
                      ),
                      Text(
                        widget.year,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: Color(0xFF1F1516),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Date',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.datePosted,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Rate',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  isLikeSelected ? 'Liked' : 'Like',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    5,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          starRating = index + 1;
                        });
                      },
                      child: ImageIcon(
                        const AssetImage('images/homepage/star.png'),
                        size: 30,
                        color: index < (starRating > 0 ? starRating : widget.starRating)
                            ? const Color(0xffff3d72e)
                            : const Color(0XFFD9D9D9),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLikeSelected = !isLikeSelected;
                    });
                  },
                  child: ImageIcon(
                    const AssetImage('images/moviepage/like.png'),
                    size: 30,
                    color: isLikeSelected
                        ? const Color(0xffb85d48) // Selected color
                        : const Color(0XFFD9D9D9), // Default color
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: reviewController..text = widget.reviewText,
              maxLines: 15,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Color(0xFF1F1516),
              ),
              decoration: InputDecoration(
                hintText: 'Write your review here...',
                hintStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
