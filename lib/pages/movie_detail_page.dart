import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmboxd/pages/add_review_page.dart';
import 'package:filmboxd/services/auth_service.dart';
import 'package:filmboxd/widgets/review_movie_widget.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  final String posterUrl;
  final String title;
  final String year;
  final String plot;
  final String director;
  final String runtime;

  const MovieDetailPage({
    required this.posterUrl,
    required this.title,
    required this.year,
    required this.plot,
    required this.director,
    required this.runtime,
    super.key,
  });

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  bool isWatchSelected = false;
  bool isWatchlistSelected = false;
  String buttonText = 'Add Rate, Review, Add to List + more';

  @override
  void initState() {
    super.initState();
    _fetchUserActivity();
  }

  Future<void> _fetchUserActivity() async {
    final authService = AuthService();
    final user = await authService.getCurrentUser();

    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.email) // Using email as the document ID
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final username = userData['username'] ?? 'Anonymous'; // Default to 'Anonymous' if no username

        final docRef = FirebaseFirestore.instance
            .collection('User Activities')
            .doc('$username-${widget.title}');

        final docSnapshot = await docRef.get();

        if (docSnapshot.exists) {
          final activityData = docSnapshot.data() as Map<String, dynamic>;
          setState(() {
            isWatchSelected = activityData['isWatched'] ?? false;
            isWatchlistSelected = activityData['isWatchlist'] ?? false;
            buttonText = isWatchSelected
                ? "You've watched this film"
                : isWatchlistSelected
                    ? "The film is in your watchlist"
                    : 'Add Rate, Review, Add to List + more';
          });
        }
      }
    }
  }

  void _showBottomModalSheet(BuildContext context) async {
    final authService = AuthService();
    final user = await authService.getCurrentUser();

    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.email) // Using email as the document ID
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final username = userData['username'] ?? 'Anonymous'; // Default to 'Anonymous' if no username

        final docRef = FirebaseFirestore.instance
            .collection('User Activities')
            .doc('$username-${widget.title}');

        final docSnapshot = await docRef.get();

        // State variables
        bool isWatchSelected = false;
        bool isLikeSelected = false;
        bool isWatchlistSelected = false;
        int starRating = 0;

        if (docSnapshot.exists) {
          final activityData = docSnapshot.data() as Map<String, dynamic>;
          isWatchSelected = activityData['isWatched'] ?? false;
          isLikeSelected = activityData['isLiked'] ?? false;
          isWatchlistSelected = activityData['isWatchlist'] ?? false;
          starRating = activityData['starRating'] ?? 0;
        }

        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
          ),
          backgroundColor: Colors.white,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Row for Watch, Like, Watchlist
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildIconButton(
                            context,
                            isWatchSelected ? 'Watched' : 'Watch',
                            'images/moviepage/watch.png',
                            isWatchSelected,
                            () => setState(() {
                              isWatchSelected = !isWatchSelected;
                            }),
                          ),
                          _buildIconButton(
                            context,
                            isLikeSelected ? 'Liked' : 'Like',
                            'images/moviepage/like.png',
                            isLikeSelected,
                            () => setState(() {
                              isLikeSelected = !isLikeSelected;
                            }),
                          ),
                          _buildIconButton(
                            context,
                            'Watchlist',
                            'images/moviepage/watchlist.png',
                            isWatchlistSelected,
                            () => setState(() {
                              isWatchlistSelected = !isWatchlistSelected;
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Star Rating Bar
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Rate',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                starRating = index + 1;
                              });
                            },
                            child: ImageIcon(
                              AssetImage('images/homepage/star.png'),
                              size: 30,
                              color: index < starRating
                                  ? Color(0xffff3d72e)
                                  : Color(0XFFD9D9D9),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Close the modal
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddReviewPage(
                                posterUrl: widget.posterUrl,
                                title: widget.title,
                                year: widget.year,
                                director: widget.director,
                                runtime: widget.runtime,
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(vertical: 0),
                          title: Center(
                            child: const Text(
                              'Add Review',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      const ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        title: Center(
                          child: Text(
                            'Add to Lists',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1F1516), // Black
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                        ),
                        onPressed: () async {
                          addActivityToDatabase(
                          widget.title,
                          username,
                          isWatchSelected,
                          isWatchlistSelected,
                          isLikeSelected,
                          starRating,
                          context);
                          setState(() {}); // Reload the current page
                        },
                        child: const Text(
                          'Done',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      } else {
        // Handle case where the user document doesn't exist
        print('User document not found.');
      }
    } else {
      // Handle case where the user is not logged in
      print('No user is currently logged in.');
    }
  }

  // Helper function to build icon buttons
  Widget _buildIconButton(
    BuildContext context,
    String label,
    String iconPath,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: ImageIcon(
              AssetImage(iconPath),
              size: 30,
              color: isSelected
                  ? (label == 'Watched'
                      ? Color(0xfff8db2b2)
                      : label == 'Liked'
                          ? Color(0xfffb85d48)
                          : Color(0xffff3d72e))
                  : const Color(0xFFD9D9D9),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xFF1F1516),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  void addActivityToDatabase(
      String movieTitle,
      String username,
      bool isWatchSelected,
      bool isWatchlistSelected,
      bool isLikeSelected,
      int starRating,
      BuildContext context) async {
    final docRef = FirebaseFirestore.instance
        .collection('User Activities')
        .doc('$username-$movieTitle');

    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      // Update existing document
      docRef.update({
        'isLiked': isLikeSelected,
        'isWatched': isWatchSelected,
        'isWatchlist': isWatchlistSelected,
        'starRating': starRating,
      }).then((value) {
        Navigator.pop(context);
      }).catchError((error) {
        print("Failed to update activity: $error");
      });
    } else {
      // Add new document
      docRef.set({
        'movieTitle': movieTitle,
        'username': username,
        'isLiked': isLikeSelected,
        'isWatched': isWatchSelected,
        'isWatchlist': isWatchlistSelected,
        'starRating': starRating,
      }).then((value) {
        Navigator.pop(context);
      }).catchError((error) {
        print("Failed to add activity: $error");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(0xfFFDEED4),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xfF1F1516),
          title: Text(
            widget.title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: ImageIcon(
              AssetImage('images/profilepage/previous-light.png'),
              color: Color(0xfFFDEED4),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
                          width: MediaQuery.of(context).size.width -
                              200, // Adjust width for title
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
            //Plot
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(widget.plot,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: Color(0xFF1F1516),
                        ),
                        textAlign: TextAlign.justify),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            //Rating
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'RATINGS',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: Color(0xFF1F1516),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 4; i++)
                  ImageIcon(
                    AssetImage('images/homepage/star.png'),
                    color: Colors.yellow,
                    size: 24.0,
                  ),
                SizedBox(width: 5),
                Text(
                  '4.0', // Replace with the actual rating value
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F1516),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
              child: SizedBox(
                width: 50, // Set the desired width here
                child: ElevatedButton(
                  onPressed: () {
                    _showBottomModalSheet(context);
                  },

                  // Button
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xfF1F1516),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                  ),
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'REVIEWS',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: Color(0xFF1F1516),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('User Reviews')
                  .where('movieTitle', isEqualTo: widget.title)
                  .snapshots(),
              builder: (context, reviewsSnapshot) {
                if (reviewsSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show loading spinner while reviews data is loading
                }

                if (!reviewsSnapshot.hasData || reviewsSnapshot.data!.docs.isEmpty) {
                  return Text('No reviews found for this movie.'); // Handle case where no reviews exist
                }

                final reviews = reviewsSnapshot.data!.docs; // List of reviews

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    final reviewData = reviews[index].data() as Map<String, dynamic>;

                    return Column(
                      children: [
                        ReviewMovieWidget(
                          username: reviewData['username'] ?? 'Anonymous',
                          reviewText: reviewData['review'] ?? 'No review text available.',
                          likes: reviewData['likes'] ?? 0,
                          comments: reviewData['comments'] ?? 0,
                          starRating: reviewData['starRating'] ?? 0.0,
                        ),
                        Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                        ),
                      ],
                    );
                  },
                );
              },
            ),

          ],
        ));
  }
}