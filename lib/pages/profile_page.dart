import 'package:filmboxd/pages/edit_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser!;
  late TabController _tabController;
  int _selectedIndex = 0;

  final List<Color> selectedTabColors = [
    Color(0xfF8DB2B2),
    Color(0xfFF3D72E),
    Color(0xfFFF9F08D),
    Color(0xfffB85D48),
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xfF1F1516),
          title: Text(
            'lavene',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
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
            ), // Style for selected tab
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
            SingleChildScrollView(
              child: Center(
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
                      SizedBox(height: 16),
              
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
                          Container(
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
                          Container(
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
                          Container(
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
              
                      SizedBox(height: 16),
              
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 20),
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
              
                      SizedBox(height: 15),
              
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Container(
                                    width: 80,
                                    height: 105,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300], // Placeholder color
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Container(
                                    width: 80,
                                    height: 105,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300], // Placeholder color
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
            ),
            Center(
              child: ListView(
                children: [
                  
                ],
              )
            ),
            Center(child: Text('Watchlists Content')),
            Center(child: Text('Lists  Content')),
          ],
        ),
      ),
    );
  }
}
