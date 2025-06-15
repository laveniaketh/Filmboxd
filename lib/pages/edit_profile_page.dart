import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmboxd/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  final TextEditingController _email = TextEditingController();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _bio = TextEditingController();

  final List<Color> selectedTabColors = [
    Color(0xfF8DB2B2),
    Color(0xfFF3D72E),
    Color(0xfffb85d48),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    //curent user
    final currentUser = AuthService().getCurrentUser();

    if (currentUser != null && currentUser.email != null) {
      _email.text = currentUser.email!;
      
    }
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

  //update user details in Firestore
  Future<void> _updateUserDetails() async {
    final currentUser = AuthService().getCurrentUser();
    if (currentUser != null && currentUser.email != null) {
      try {
        await FirebaseFirestore.instance.collection('Users').doc(currentUser.email).update({
          'name': _name.text,
          'username': _username.text,
          'bio': _bio.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          
          SnackBar(
            content: Text(
              'Profile updated successfully',
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
            } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to update profile: $e',
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
      }
    }
  }

//sign user out method
  // void signUserOut() {
  //   FirebaseAuth.instance.signOut();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xfF1F1516),
          title: Text(
            'Edit Profile',
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
          actions: [
            IconButton(
              //save button
              icon: ImageIcon(
                AssetImage('images/profilepage/save-light.png'),
                color: Color(0xfFFDEED4),
              ),
              onPressed: (){
                _updateUserDetails();
                
              },
            ),
          ],
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(AuthService().getCurrentUser()?.email)
                .snapshots(),
            builder: (context, snapshot) {
              //get user data
              if (snapshot.hasData) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;
                _name.text = userData['name'];
                _username.text = userData['username'];
                _bio.text = userData['bio'];

                return ListView(
                  children: [
                    //change profile avatar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 30),
                      child: Column(
                        children: [
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

                          //change photo
                          Text(
                            'Change Photo',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xfF1F1516),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // about you
                          Text(
                            'About you',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xfF1F1516),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),

                          //name
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Name',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xfF1F1516),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _name,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xfF1F1516),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration:
                                      InputDecoration.collapsed(hintText: null),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 15),

                          //username
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Username',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xfF1F1516),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _username,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xfF1F1516),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration:
                                      InputDecoration.collapsed(hintText: null),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 15),

                          //bio
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Bio',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xfF1F1516),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _bio,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xfF1F1516),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration:
                                      InputDecoration.collapsed(hintText: null),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
