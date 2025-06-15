import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmboxd/pages/add_review_page.dart';
import 'package:filmboxd/pages/edit_review_page.dart';
import 'package:filmboxd/services/omdb_service.dart';
import 'package:filmboxd/widgets/review_movie_widget.dart';
import 'package:flutter/material.dart';

class ReviewPostDetailPage extends StatelessWidget {
  final String posterUrl;
  final String movieTitle;
  final String year;
  final String username;
  final String reviewText;
  final int starRating;
  final bool isLikeSelected;
  final String datePosted;

  const ReviewPostDetailPage(
      {required this.posterUrl,
      required this.movieTitle,
      required this.year,
      required this.username,
      required this.reviewText,
      required this.starRating,
      super.key,
      required,
      required this.isLikeSelected,
      required this.datePosted});




  void _showBottomModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: ImageIcon(
                  AssetImage('images/profilepage/edit.png'),
                  color: Color(0xfF1F1516),
                ),
                title: const Text(
                  'Edit',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                    color: Color(0xfF1F1516),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditReviewPage(
                        movieTitle: movieTitle,
                        year: year,
                        posterUrl: posterUrl,
                        starRating: starRating,
                        reviewText: reviewText,
                        username: username,
                        isLikeSelected: isLikeSelected,
                        datePosted: datePosted,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: ImageIcon(
                  AssetImage('images/profilepage/delete.png'),
                  color: Color(0xfF1F1516),
                ),
                title: const Text(
                  'Delete',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                    color: Color(0xfF1F1516),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          'Delete Review',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xfF1F1516),
                          ),
                        ),
                        content: const Text(
                          'Are you sure you want to delete this review?',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Color(0xfF1F1516),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Color(0xFFf8DB2B2),
                              ),
                            ),
                          ),
                          //DELETE REVIEW FROM FIREBASE
                          TextButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('User Reviews')
                                  .where('movieTitle', isEqualTo: movieTitle)
                                  .where('username', isEqualTo: username)
                                  .where('review', isEqualTo: reviewText)
                                  .get()
                                  .then((snapshot) {
                                for (DocumentSnapshot ds in snapshot.docs) {
                                  ds.reference.delete();
                                }
                              });
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Color(0xfFFB85D48),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(0xfFFDEED4),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xfF1F1516),
          title: const Text(
            'Review',
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
                  'images/profilepage/menu.png',
                  color: const Color(0xfFFDEED4),
                  width: 24,
                  height: 24,
                ),
                onPressed: () {
                  _showBottomModalSheet(context);
                }),
          ],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              child: Icon(Icons.person,
                                  size: 24, color: Colors.white),
                              backgroundColor: Colors.grey[300],
                            ),
                            SizedBox(width: 5),
                            Text(
                              username,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Color(0xfF1F1516),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            SizedBox(
                              // width: MediaQuery.of(context).size.width -
                              //     0, // Adjust width for title
                              child: Text(
                                '$movieTitle ',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1F1516),
                                ),
                                overflow: TextOverflow.visible,
                                softWrap: true,
                              ),
                            ),
                            // const SizedBox(width: 7),
                            Text(
                              year,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                color: Color(0xFF1F1516),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Row(
                              children: List.generate(
                                starRating,
                                (index) => ImageIcon(
                                  AssetImage('images/homepage/star.png'),
                                  color: Color(0xffF3D72E),
                                  size: 15,
                                ),
                              ),
                            ),
                            if (isLikeSelected)
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: ImageIcon(
                                  const AssetImage('images/moviepage/like.png'),
                                  size: 15,
                                  color: const Color(0xfffb85d48),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Watched on $datePosted",
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  posterUrl.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.network(
                            posterUrl,
                            width: 60,
                            height: 90,
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      reviewText,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Color(0xfF1F1516),
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            //like and comment
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ImageIcon(
                        AssetImage('images/homepage/heart.png'),
                        color: Color(0xfffb85d48),
                        size: 24,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '0',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Color(0xfF1F1516),
                        ),
                      ),
                      SizedBox(width: 10),
                      ImageIcon(
                        AssetImage('images/homepage/comment.png'),
                        color: Color(0xfF1F1516),
                        size: 24,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '1',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Color(0xfF1F1516),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
