import 'package:filmboxd/models/movie_lists_homepage_model.dart';
import 'package:filmboxd/models/review_model.dart';
import 'package:filmboxd/widgets/list_post_widget.dart';
import 'package:filmboxd/widgets/movie_poster_scroll_widget.dart';
import 'package:filmboxd/widgets/review_post_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser!;
  late TabController _tabController;
  int _selectedIndex = 0;

  final List<Color> selectedTabColors = [
    Color(0xfF8DB2B2),
    Color(0xfFF3D72E),
    Color(0xfffB85D48),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Method to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

//sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final ReviewPost sampleReview = ReviewPost(
  movieTitle: "Moana",
  yearOfRelease: "2024",
  moviePoster: "https://path_to_example_movie_poster.com/poster.jpg", // Replace with actual image URL
  textPost: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
  username: "janna",
  profileImage: "https://path_to_profile_image.com/profile.jpg", // Replace with actual profile image URL
  numberOfLikes: 10,
  numberOfComments: 3, starRating: 3.0,
);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xfF1F1516),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/filmboxd-logo.png',
                height: 50.0,
              ),
            ],
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                child: Text(
                  "Films",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Reviews",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Lists",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ), // Style for selected tab
            labelColor: Colors.yellow,
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            unselectedLabelColor: Colors.white,
            indicator: BoxDecoration(
              color: selectedTabColors[_tabController.index],
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: (index) {
              setState(() {});
            },
            indicatorPadding:
                EdgeInsets.symmetric(horizontal: -30, vertical: 10),
          ),
        ),
        
        body: TabBarView(
          controller: _tabController,
          children: [
            Center(
                child: Padding(
              padding:
                  const EdgeInsets.only( left: 10.0, right: 10.0),
              child: ListView(
                //Films Tab

                children: [
                  const SizedBox(height: 5),
                  //Popular this week
                  popularThisWeekSection(),

                  const SizedBox(height: 15),

                  //New from Friends
                  newFromFriendsSection(),

                  const SizedBox(height: 15),

                  // Popular with Friends
                  popularWithFriendsSection(),
                ],
              ),
            )),
            Center(
              child: ListView(
                // Reviews Tab
                children: [
                  // Container(
                  //   // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //   padding: EdgeInsets.all(15),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     // borderRadius: BorderRadius.circular(12),
                  //     // boxShadow: [
                  //     //   BoxShadow(
                  //     //     color: Colors.black.withOpacity(0.1),
                  //     //     blurRadius: 6,
                  //     //     offset: Offset(0, 3),
                  //     //   ),
                  //     // ],
                  //   ),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       // Poster Placeholder
                  //       Container(
                  //         width: 60,
                  //         height: 90,
                  //         decoration: BoxDecoration(
                  //           color: Colors.grey[300],
                  //           borderRadius: BorderRadius.circular(5),
                  //         ),
                  //       ),
                  //       SizedBox(width: 16),
                  //       // Details Section
                  //       Expanded(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             // Title and Year
                  //             Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 RichText(
                  //                   text: TextSpan(
                  //                     text: 'Moana 2 ',
                  //                     style: TextStyle(
                  //                       fontFamily: 'Poppins',
                  //                       fontSize: 15,
                  //                       color: Color(0xfF1F1516),
                  //                       fontWeight: FontWeight.bold,
                  //                     ),
                  //                     children: [
                  //                       TextSpan(
                  //                         text: '2024',
                  //                         style: TextStyle(
                  //                           fontFamily: 'Poppins',
                  //                           fontSize: 12,
                  //                           color: Colors.grey[600],
                  //                           fontWeight: FontWeight.w400,
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 Row(
                  //                   children: [
                  //                     Text(
                  //                       'janna',
                  //                       style: TextStyle(
                  //                         fontFamily: 'Poppins',
                  //                         fontSize: 12,
                  //                         color: Color(0xfF1F1516),
                  //                         fontWeight: FontWeight.bold,
                  //                       ),
                  //                     ),
                  //                     SizedBox(width: 4),
                  //                     CircleAvatar(
                  //                       radius: 12,
                  //                       backgroundImage: AssetImage(
                  //                           'images/homepage/profile.png'),
                  //                       backgroundColor: Colors.grey[300],
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //             // SizedBox(height: 8),
                  //             // Rating
                  //             Row(
                  //               children: List.generate(
                  //                 5,
                  //                 (index) => ImageIcon(
                  //                   AssetImage('images/homepage/star.png'),
                  //                   color: Color(0xfffF3D72E),
                  //                   size: 13,
                  //                 ),
                  //               ),
                  //             ),
                  //             SizedBox(height: 8),
                  //             // Review Text
                  //             Text(
                  //               'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                  //               maxLines: 3,
                  //               overflow: TextOverflow.ellipsis,
                  //               style: TextStyle(
                  //                 fontFamily: 'Poppins',
                  //                 fontSize: 12,
                  //                 color: Color(0xfF1F1516),
                  //                 // fontWeight: FontWeight.bold,
                  //               ),
                  //             ),
                  //             SizedBox(height: 12),
                  //             // Likes, Comments, Category
                  //             Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Row(
                  //                   children: [
                  //                     ImageIcon(
                  //                       AssetImage('images/homepage/heart.png'),
                  //                       color: Color(0xfFFB85D48),
                  //                       size: 24,
                  //                     ),
                  //                     SizedBox(width: 4),
                  //                     Text('10',
                  //                         style: TextStyle(
                  //                           fontFamily: 'Poppins',
                  //                           fontSize: 12,
                  //                           color: Color(0xfF1F1516),
                  //                         )),
                  //                     SizedBox(width: 10),
                  //                     ImageIcon(
                  //                       AssetImage('images/homepage/comment.png'),
                  //                       color: Color(0xfF1F1516),
                  //                       size: 24,
                  //                     ),
                  //                     SizedBox(width: 4),
                  //                     Text('3',
                  //                         style: TextStyle(
                  //                           fontFamily: 'Poppins',
                  //                           fontSize: 12,
                  //                           color: Color(0xfF1F1516),
                  //                         )),
                  //                     SizedBox(width: 10),
                  //                     Container(
                  //                       padding: EdgeInsets.symmetric(
                  //                           horizontal: 8, vertical: 4),
                  //                       decoration: BoxDecoration(
                  //                         color: Color(0xFFF8DB2B2),
                  //                         borderRadius:
                  //                             BorderRadius.circular(10),
                  //                       ),
                  //                       child: Text(
                  //                         'Film >',
                  //                         style: TextStyle(
                  //                           fontFamily: 'Poppins',
                  //                           fontSize: 12,
                  //                           color: Colors.white,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),  

                  ReviewPostWidget(review: sampleReview),
                  
                ],
              ),
            ),
            Center(child: 
            ListView(
              // Lists Tab
              children: [
                ListPostWidget(),
              ],

            )
            ),
          ],
        ),
      ),
    );
  }

  Column popularWithFriendsSection() {
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Popular with Friends',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),
                    MoviePosterScrollWidget(movieTitles: MovieLists.popularWithFriends),

                    // Horizontal Scroll of Posters
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: List.generate(10, (index) {
                    //       return Padding(
                    //         padding: const EdgeInsets.only(right: 10.0),
                    //         child: Container(
                    //           width: 100,
                    //           height: 150,
                    //           decoration: BoxDecoration(
                    //             color: Colors.grey[300], // Placeholder color
                    //             borderRadius: BorderRadius.circular(8),
                    //           ),
                    //           // child: Image.network(
                    //           //   'https://via.placeholder.com/100x150',
                    //           //   fit: BoxFit.cover,
                    //           // ),
                    //         ),
                    //       );
                    //     }),
                    //   ),
                    // ),
                  ],
                );
  }

  Column newFromFriendsSection() {
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New from friends',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),
                    MoviePosterScrollWidget(movieTitles: MovieLists.newFromFriends),

                    // Horizontal Scroll of Posters
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: List.generate(10, (index) {
                    //       return Padding(
                    //         padding: const EdgeInsets.only(right: 10.0),
                    //         child: Container(
                    //           width: 100,
                    //           height: 150,
                    //           decoration: BoxDecoration(
                    //             color: Colors.grey[300], // Placeholder color
                    //             borderRadius: BorderRadius.circular(8),
                    //           ),
                    //           // child: Image.network(
                    //           //   'https://via.placeholder.com/100x150',
                    //           //   fit: BoxFit.cover,
                    //           // ),
                    //         ),
                    //       );
                    //     }),
                    //   ),
                    // ),
                  ],
                );
  }

  Column popularThisWeekSection() {
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Popular this week',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),
                    MoviePosterScrollWidget(movieTitles: MovieLists.popularThisWeek),

                    // Horizontal Scroll of Posters
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: List.generate(10, (index) {
                    //       return Padding(
                    //         padding: const EdgeInsets.only(right: 10.0),
                    //         child: Container(
                    //           width: 100,
                    //           height: 150,
                    //           decoration: BoxDecoration(
                    //             color: Colors.grey[300], // Placeholder color
                    //             borderRadius: BorderRadius.circular(8),
                    //           ),
                    //           // child: Image.network(
                    //           //   'https://via.placeholder.com/100x150',
                    //           //   fit: BoxFit.cover,
                    //           // ),
                    //         ),
                    //       );
                    //     }),
                    //   ),
                    // ),
                  ],
                );
  }
}
