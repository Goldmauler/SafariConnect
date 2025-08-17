// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import
import 'firebase_options.dart'; // Import
import 'pages/landing_page.dart';
import 'pages/home_page.dart';

// Make main async
void main() async {
  // Add these two lines
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafariConnect',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      home: const LandingPage(),
      routes: {
        '/main': (context) => const HomePage(),
      },
    );
  }
}