import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nuur_din/features/app/splash_screen/splash_screen.dart';
import 'package:nuur_din/features/user_auth/presentation/pages/home_page.dart';
import 'package:nuur_din/features/user_auth/presentation/pages/login_page.dart';
import 'package:nuur_din/features/user_auth/presentation/pages/sign_up_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDL2-WrYvvxqHDaLG1tnYHq26NpwNEdYos",
        appId: "1:726916778902:android:c67f769273de8f017eabb7",
        messagingSenderId: "540215271818",
        projectId: "flutter-firebase-9c136",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  // 🔥 Initialize Firebase App Check
  await FirebaseAppCheck.instance.activate(
   // androidProvider: AndroidProvider.debug, // Use debug mode during development
    androidProvider: AndroidProvider.playIntegrity, // Play Integrity for Android

  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KUKU App',
      routes: {
        '/': (context) => SplashScreen(
          child: LoginPage(),
        ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
