import 'package:filmboxd/models/review_model.dart';
import 'package:filmboxd/pages/edit_profile_page.dart';
import 'package:filmboxd/services/auth_service.dart';
import 'package:filmboxd/widgets/list_post_widget.dart';
import 'package:filmboxd/widgets/movie_poster_grid_widget.dart';
import 'package:filmboxd/widgets/review_post_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:filmboxd/pages/auth_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser!;
  late TabController _tabController;
  final int _selectedIndex = 0;

  final List<Color> selectedTabColors = [
    Color(0xfF8DB2B2),
    Color(0xfFF3D72E),
    Color(0xffff9f08d),
    Color(0xfffb85d48),
  ];

  final ReviewPost sampleReview = ReviewPost(
    movieTitle: "Moana",
    yearOfRelease: "2024",
    moviePoster: "", // Replace with actual image URL
    textPost: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    username: "lavene",
    profileImage:
        "https://path_to_profile_image.com/profile.jpg", // Replace with actual profile image URL
    numberOfLikes: 10,
    numberOfComments: 3,
    starRating: 3.0,
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xfF1F1516),
          title: GestureDetector(
            onTap: () async {
              // Show the dropdown menu when the title is tapped
              await showMenu(
                context: context,
                position: RelativeRect.fromLTRB(100, 70, 100, 0),
                items: [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text('Logout'),
                  ),
                ],
              ).then((value) {
                if (value == 0) {
                  AuthService().signOut();
                }
              });
            },
            child: Text(
              'lavene',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 11,
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
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Watchlists",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 11,
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
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            labelColor: Colors.yellow,
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11,
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
            ListView(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Profile Icon
                        CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              Colors.grey.shade300, // Placeholder color
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 10),

                        // Username
                        Text(
                          'laveniaketh',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xfF1F1516),
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 16),

                        // Following, Followers, and Likes
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Column(
                                children: [
                                  Text(
                                    '10',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xfF1F1516),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Following',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xfF1F1516),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Column(
                                children: [
                                  Text(
                                    '10',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xfF1F1516),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Followers',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xfF1F1516),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Column(
                                children: [
                                  Text(
                                    '10',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xfF1F1516),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Likes',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xfF1F1516),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 10),

                        // Edit Profile Button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfilePage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xfF1F1516), // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Bio
                        Text(
                          'may we find solace in film.',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xfF1F1516),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 10),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Favorites',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5), //\
                            // Top 4 Movie Posters
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(4, (index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                    width: 80,
                                    height: 105,
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.grey[300], // Placeholder color
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    // child: Image.network(
                                    //   'https://via.placeholder.com/100x150',
                                    //   fit: BoxFit.cover,
                                    // ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Recent Activity',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5), //\
                            // Top 4 Movie Posters
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(4, (index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                    width: 80,
                                    height: 105,
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.grey[300], // Placeholder color
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    // child: Image.network(
                                    //   'https://via.placeholder.com/100x150',
                                    //   fit: BoxFit.cover,
                                    // ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Center(
                child: ListView(
              children: [
                //Review Tabs
                ReviewPostWidget(review: sampleReview),
              ],
            )),
            Center(
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: MoviePosterGridView(),
                    ),
                  ],
                ),
              ),
            ),
            Center(
                child: ListView(
              children: [
                // Lists
                ListPostWidget(),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
