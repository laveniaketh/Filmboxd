import 'package:filmboxd/models/review_model.dart';
import 'package:filmboxd/pages/edit_profile_page.dart';
import 'package:filmboxd/services/auth_service.dart';
import 'package:filmboxd/widgets/list_post_widget.dart';
import 'package:filmboxd/widgets/movie_poster_grid_widget.dart';
import 'package:filmboxd/widgets/review_post_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:filmboxd/pages/auth_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        backgroundColor: Colors.white, 
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xfF1F1516),
          title: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(AuthService().getCurrentUser()?.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;
                final name = userData['name'];

                return GestureDetector(
                  onTap: () async {
                    // Show the dropdown menu when the title is tapped
                    await showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(150, 70, 145, 0),
                      items: [
                        PopupMenuItem<int>(
                          value: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Log out',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white,
                    ).then((value) {
                      if (value == 0) {
                        AuthService().signOut();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => AuthPage()),
                        );
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      ImageIcon(
                        AssetImage(
                            'images/profilepage/dropdown-arrow-menu.png'),
                        color: Color(0xfFFDEED4),
                        size: 10.0,
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                AuthService().signOut();
                return Center(child: Text('Error occurred. Please try again.'));
              }
              return CircularProgressIndicator();
            },
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
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(AuthService().getCurrentUser()?.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final userData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  final name = userData['name'];
                  final username = userData['username'];
                  final bio = userData['bio'];

                  return ListView(
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
                                username,
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
                                  backgroundColor:
                                      Color(0xfF1F1516), // Button color
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
                                bio,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Container(
                                          width: 80,
                                          height: 105,
                                          decoration: BoxDecoration(
                                            color: Colors
                                                .grey[300], // Placeholder color
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Container(
                                          width: 80,
                                          height: 105,
                                          decoration: BoxDecoration(
                                            color: Colors
                                                .grey[300], // Placeholder color
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            Center(
              child: FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection(
                        'Users') // Assuming there's a 'Users' collection
                    .doc(AuthService()
                        .getCurrentUser()
                        ?.email) // Using current user's email as the document ID
                    .get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show loading spinner while data is loading
                  }

                  if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                    return Text(
                        'User not found.'); // Handle case where user document doesn't exist
                  }

                  final userData =
                      userSnapshot.data!.data() as Map<String, dynamic>;
                  final username = userData[
                      'username']; // Assuming 'username' field exists in the 'Users' document

                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('User Reviews') // Collection for reviews
                        .where('username',
                            isEqualTo: username) // Filter reviews by username
                        .snapshots(),
                    builder: (context, reviewsSnapshot) {
                      if (reviewsSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Show loading spinner while reviews data is loading
                      }

                      if (!reviewsSnapshot.hasData ||
                          reviewsSnapshot.data!.docs.isEmpty) {
                        return Text(
                            'No reviews found for this user.'); // Handle case where no reviews exist
                      }

                      final reviews =
                          reviewsSnapshot.data!.docs; // List of reviews

                      return ListView.builder(
                        itemCount: reviews.length,
                        itemBuilder: (context, index) {
                          final reviewData =
                              reviews[index].data() as Map<String, dynamic>;

                          return Column(
                            children: [
                              ReviewPostWidget(
                                movieTitle: reviewData['movieTitle'] ??
                                    'Unknown Movie', // Provide a default value
                                reviewText: reviewData['review'] ??
                                    'No review text available.', // Provide a default value
                                starRating: reviewData['starRating'] ??
                                    0, // Provide a default value
                                username: reviewData['username'] ??
                                    'Anonymous', // Provide a default value
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
                  );
                },
              ),
            ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
