
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nuur_din/features/user_auth/presentation/pages/settings.dart';
import 'package:nuur_din/features/user_auth/presentation/models/post_model.dart';
import 'package:nuur_din/features/user_auth/presentation/pages/post_details.dart';
import 'package:nuur_din/features/user_auth/presentation/pages/detect_deseases.dart';

import '../../../../global/common/toast.dart';


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
  PostPage(),
    DetectDiseasesPage(),
    // productscreen(),


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
                title: Text('Profile'),
                onTap: () {

                } ),

              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Sign Out"),
                onTap: () {

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




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      'https://django-socialmediaapp-s2ky.onrender.com/graphql/',
    );

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        home: PostPage(),
      ),
    );
  }
}



  @override
  class PostPage extends StatelessWidget {
  final String query = r'''
    query {
      posts {
        title
        photo
        caption
        createdAt
        updatedAt
        viewers
      }
    }
  ''';

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
  title: Text("Posts"),
  ),
  body: Query(
  options: QueryOptions(document: gql(query)),
  builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
  if (result.isLoading) {
  return Center(child: CircularProgressIndicator());
  }

  if (result.hasException) {
  return Center(child: Text("Error: ${result.exception.toString()}"));
  }

  final posts = result.data?['posts'];
  if (posts == null || posts.isEmpty) {
  return Center(child: Text("No Posts Found!"));
  }

  return ListView.builder(
  padding: EdgeInsets.all(10),
  itemCount: posts.length,
  itemBuilder: (context, index) {
  final post = posts[index];


  return InkWell(
  onTap: () {
  Navigator.push(
  context,
  MaterialPageRoute(
  builder: (_) => PostDetailPage(post: post),
  ),
  );
  },
  child: Container(
  margin: EdgeInsets.symmetric(vertical: 8),
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(12),
  boxShadow: [
  BoxShadow(
  color: Colors.black12,
  blurRadius: 6,
  offset: Offset(0, 3),
  ),
  ],
  ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post['photo'] != null && post['photo'].toString().isNotEmpty)

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              post['photo'],

              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        SizedBox(height: 8),
        Text(
          post['title'] ?? "No Title",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          post['caption'] ?? "No caption",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Views: ${post['viewers'] ?? 0}"),
            Text(
              post['updatedAt'] != null
                  ? GetTimeAgo.parse(DateTime.parse(post['updatedAt']))
                  : "",
            ),
          ],
        )

      ],
    ),

  ),
  );
  },
  );
  },
  ),
  );
  }
  }





