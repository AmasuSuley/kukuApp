
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nuur_din/features/app/splash_screen/splash_screen.dart';
import 'package:nuur_din/features/user_auth/presentation/pages/home_page.dart';
import 'package:nuur_din/features/user_auth/presentation/pages/login_page.dart';
import 'package:nuur_din/features/user_auth/presentation/pages/sign_up_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await initHiveForFlutter();


  final HttpLink httpLink = HttpLink(
    'https://django-socialmediaapp-s2ky.onrender.com/graphql/',
  );

  final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: httpLink,
  );

  runApp(
    GraphQLProvider(
      client: ValueNotifier(client),
      child: CacheProvider(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KUKU App',
      routes: {
        '/': (context) => SplashScreen(
          child: HomePage(),
        ),
        // '/login': (context) => LoginPage(),
        // '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
