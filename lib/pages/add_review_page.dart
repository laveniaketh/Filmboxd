import 'package:filmboxd/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddReviewPage extends StatefulWidget {
  final String posterUrl;
  final String title;
  final String year;
  final String director;
  final String runtime;

  const AddReviewPage({
    required this.posterUrl,
    required this.title,
    required this.year,
    required this.director,
    required this.runtime,
    super.key,
  });

  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

void addReviewToDatabase(String movieTitle, String username, DateTime date,
    bool isLikedSelected, String review, int starRating, BuildContext context) {
  FirebaseFirestore.instance.collection('User Reviews').add({
    'movieTitle': movieTitle,
    'username': username,
    'date': date,
    'isLiked': isLikedSelected,
    'review': review,
    'starRating': starRating,
  }).then((value) {
    print("Review Added");
    Navigator.pop(context);
  }).catchError((error) {
    print("Failed to add review: $error");
  });
}

class _AddReviewPageState extends State<AddReviewPage> {
  final reviewController = TextEditingController();
  int starRating = 0;
  bool isLikeSelected = false;

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
                  final username = userData['username'] ??
                      'Anonymous'; // Default to 'Anonymous' if no username

                  addReviewToDatabase(
                    widget.title,
                    username,
                    DateTime.now(),
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
                          width: 100,
                          height: 170,
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
                          widget.title,
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
                      const SizedBox(height: 7),
                      Text(
                        "${widget.year} | DIRECTED BY",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: Color(0xFF1F1516),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.director,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F1516),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.runtime,
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
                  'Date',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${DateFormat('MMMM d, yyyy').format(DateTime.now())}',
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
          // const SizedBox(height: 20),
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
          const SizedBox(height: 8),
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
                        color: index < starRating
                            ? const Color(0xffff3d72e)
                            : const Color(0XFFD9D9D9),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
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
                        ? const Color(0xfffb85d48)
                        : const Color(0XFFD9D9D9),
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 20),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Review',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: reviewController,
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
          ),
        ],
      ),
    );
  }
}
