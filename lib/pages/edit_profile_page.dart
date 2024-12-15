import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser!;
  late TabController _tabController;
  int _selectedIndex = 0;
  TextEditingController _name = TextEditingController(text: "lavene");
  TextEditingController _username = TextEditingController(text: "laveniaketh");
  TextEditingController _bio = TextEditingController(text: "may we find solace in film.");

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
              icon: ImageIcon(
          AssetImage('images/profilepage/save-light.png'),
          color: Color(0xfFFDEED4),
              ),
              onPressed: () {
          // Add your onPressed code here!
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            //change profile avatar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade300, // Placeholder color
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
                      fontWeight: FontWeight.w400,
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
                      fontWeight: FontWeight.w400,
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
                      fontWeight: FontWeight.w400,
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
                      decoration: InputDecoration.collapsed(hintText: null),
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
                      fontWeight: FontWeight.w400,
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
                      decoration: InputDecoration.collapsed(hintText: null),
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
                      fontWeight: FontWeight.w400,
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
                      decoration: InputDecoration.collapsed(hintText: null),
                      textAlign: TextAlign.end,
                      ),
                    ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
