import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nuur_din/features/user_auth/presentation/pages/settings.dart';
import 'package:nuur_din/features/user_auth/presentation/pages/products.dart';
import 'package:nuur_din/features/user_auth/presentation/pages/profile.dart';
import 'package:nuur_din/features/user_auth/presentation/pages/detect_deseases.dart';
import 'package:nuur_din/features/user_auth/presentation/models/chart_msg.dart';
import 'package:nuur_din/features/user_auth/presentation/models/inbox.dart';


import '../../../../global/common/toast.dart';
import '../models/create_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isDarkTheme = false; // Theme state

  void _toggleTheme(bool isDark) {
    setState(() {
      _isDarkTheme = isDark;
    });
  }

  List<Widget> get _pages => [
    HomeContent(),
    DetectDiseasesPage(),
    productscreen(),
    chatpage(),


    SettingsPage(

      onThemeChanged: _toggleTheme,
      isDarkTheme: _isDarkTheme,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
            title: Text("KUKU App"),
          backgroundColor: Colors.teal
        ),

        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.medical_services), label: 'Detect Diseases'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Product'),
            BottomNavigationBarItem(icon: Icon(Icons.forum), label: 'Chart'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.teal),
                child: Text('KUKU App', style: TextStyle(color: Colors.white, fontSize: 24)),
              ),

              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('charting'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => chatscreen(
                        receiverId: '1', // Pass the actual user ID
                        receiverName: 'John Doe', // Pass the user's name
                      ),
                    ),
                  );

                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('create'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  CreateDataPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                },
              ),

              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Sign Out"),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, "/login");
                  showToast(message: "User is successfully signed Out");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: _selectedIndex == index,
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        Navigator.pop(context);
      },
    );
  }
}

// Updated HomeContent class to include posts
class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<bool> likedStatus = [false, false, false]; // Stores like status for each post

  void _toggleLike(int index) {
    setState(() {
      likedStatus[index] = !likedStatus[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> posts = [
      {
        "title": "Fresh Organic Chicken",
        "image": "https://plus.unsplash.com/premium_photo-1661767136966-38d5999f819a?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8b3JnYW5pYyUyMGNoaWNrZW58ZW58MHx8MHx8fDA%3D",
      },
      {
        "title": "Premium Chicken Feed",
        "image": "https://images.unsplash.com/photo-1569466593977-94ee7ed02ec9?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8b3JnYW5pYyUyMGNoaWNrZW58ZW58MHx8MHx8fDA%3D",
      },
      {
        "title": "High-Quality Eggs",
        "image": "https://media.istockphoto.com/id/1056759048/photo/organic-farm-and-free-range-chicken-eggs.webp?a=1&b=1&s=612x612&w=0&k=20&c=LRLYanTiPafKmFL1yAs2FAA1GfQOEsFHaarkR5EUHw4=",
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(posts[index]["image"]!, height: 150, width: double.infinity, fit: BoxFit.cover),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(posts[index]["title"]!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        likedStatus[index] ? Icons.favorite : Icons.favorite_border,
                        color: likedStatus[index] ? Colors.red : Colors.grey,
                      ),
                      onPressed: () => _toggleLike(index),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        // Implement comment functionality
                      },
                      icon: Icon(Icons.comment, color: Colors.teal),
                      label: Text("Comment"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


