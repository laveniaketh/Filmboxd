import 'package:filmboxd/pages/add_review_page.dart';
import 'package:filmboxd/widgets/review_movie_widget.dart';
import 'package:filmboxd/widgets/review_post_widget.dart';
import 'package:filmboxd/widgets/star_rating_widget.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatelessWidget {
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

  // void _showBottomModalSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
  //     ),
  //     backgroundColor: Colors.white,
  //     builder: (BuildContext context) {
  //       return Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 SizedBox(
  //                   width: 100,
  //                   child: Column(
  //                     children: [
  //                       ImageIcon(
  //                         AssetImage('images/moviepage/watch.png'),
  //                         size: 30,
  //                         color: Color(0xfFD9D9D9),
  //                       ),
  //                       SizedBox(height: 10),
  //                       Text(
  //                         'Watch',
  //                         style: TextStyle(
  //                           fontFamily: 'Poppins',
  //                           color: Color(0xfF1F1516),
  //                           fontSize: 12,
  //                           fontWeight: FontWeight.w400,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   width: 100,
  //                   child: Column(
  //                     children: [
  //                       ImageIcon(
  //                         AssetImage('images/moviepage/like.png'),
  //                         size: 30,
  //                         color: Color(0xfFD9D9D9),
  //                       ),
  //                       SizedBox(height: 10),
  //                       Text(
  //                         'Like',
  //                         style: TextStyle(
  //                           fontFamily: 'Poppins',
  //                           color: Color(0xfF1F1516),
  //                           fontSize: 12,
  //                           fontWeight: FontWeight.w400,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   width: 100,
  //                   child: Column(
  //                     children: [
  //                       ImageIcon(
  //                         AssetImage('images/moviepage/watchlist.png'),
  //                         size: 30,
  //                         color: Color(0xfFD9D9D9),
  //                       ),
  //                       SizedBox(height: 10),
  //                       Text(
  //                         'Watchlist',
  //                         style: TextStyle(
  //                           fontFamily: 'Poppins',
  //                           color: Color(0xfF1F1516),
  //                           fontSize: 12,
  //                           fontWeight: FontWeight.w400,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //             Divider(
  //               color: Colors.grey[300],
  //               thickness: 1,
  //               indent: 20,
  //               endIndent: 20,
  //             ),
  //             const SizedBox(height: 8),
  //             const Text(
  //               'Rate',
  //               style: TextStyle(
  //                 fontFamily: 'Poppins',
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             const SizedBox(height: 8),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: List.generate(
  //                 5,
  //                 (index) => ImageIcon(
  //                   AssetImage('images/homepage/star.png'),
  //                   size: 30,
  //                   color: index < 5 ? Colors.yellow : Colors.grey,
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(height: 8),
  //             Divider(
  //               color: Colors.grey[300],
  //               thickness: 1,
  //               indent: 20,
  //               endIndent: 20,
  //             ),
  //             const ListTile(
  //               contentPadding: EdgeInsets.symmetric(vertical: 0),
  //               title: Center(
  //                 child: Text(
  //                   'Add Review',
  //                   style: TextStyle(
  //                     fontFamily: 'Poppins',
  //                     fontSize: 14,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Divider(
  //               color: Colors.grey[300],
  //               thickness: 1,
  //               indent: 20,
  //               endIndent: 20,
  //             ),
  //             const ListTile(
  //               contentPadding: EdgeInsets.symmetric(vertical: 0),
  //               title: Center(
  //                 child: Text(
  //                   'Add to Lists',
  //                   style: TextStyle(
  //                     fontFamily: 'Poppins',
  //                     fontSize: 14,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: const Color(0xFF1F1516), // Black
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //                 padding: const EdgeInsets.symmetric(horizontal: 50),
  //               ),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: const Text(
  //                 'Done',
  //                 style: TextStyle(
  //                   fontFamily: 'Poppins',
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  void _showBottomModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        // State variables
        bool isWatchSelected = false;
        bool isLikeSelected = false;
        bool isWatchlistSelected = false;
        int starRating = 0;

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
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => AddReviewPage(
                        posterUrl: posterUrl, 
                        title: title, 
                        year: year, 
                        director: director, 
                        runtime: runtime,

                      ),
                      ),
                    ),
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
                    onPressed: () {
                      Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(0xfFFDEED4),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xfF1F1516),
          title: Text(
            title,
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
                  posterUrl.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.network(
                            posterUrl,
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
                            title,
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
                          "$year | DIRECTED BY",
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: Color(0xFF1F1516),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          director,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F1516),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          runtime,
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
                    child: Text(plot,
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
                    'Add Rate, Review, Add to List + more',
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

            ReviewMovieWidget(
              username: 'janna',
              reviewText:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, se',
              likes: 125,
              comments: 5,
              rating: 4.0, // Adjust this for the star rating
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
          ],
        ));
  }
}
