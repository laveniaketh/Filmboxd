import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xfF1F1516),
          title: Text(
            'Search',
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
                  "Users",
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
                child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: const Color(0xff1D1617).withOpacity(0.11),
                        blurRadius: 40,
                        spreadRadius: 0.0)
                  ]),
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(15),
                        hintText: 'Search Pancake',
                        hintStyle: const TextStyle(
                            color: Color(0xffDDDADA), fontSize: 14),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                              'images/homepage/search-selected.png'),
                        ),
                        suffixIcon: SizedBox(
                          width: 100,
                          child: IntrinsicHeight(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const VerticalDivider(
                                    color: Colors.black,
                                    indent: 10,
                                    endIndent: 10,
                                    thickness: 0.1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Image.asset(
                                        'images/homepage/search-selected.png'),
                                  ),
                                ]),
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none)),
                  ),
                ),
              ],
            )),
            Center(child: Text('Users Content')),
            Center(child: Text('Lists  Content')),
          ],
        ),
      ),
    );
  }
}
