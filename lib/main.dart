// lib/main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/landing_page.dart'; // Updated path
import 'main_screen.dart'; // Updated path
import 'pages/travel_page.dart'; // Updated path

void main() async {
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
      // The app starts with the landing page
      home: const LandingPage(),
      // Define routes for any pages you want to navigate to by name
      routes: {
        '/main': (context) => const MainScreen(),
        '/travel': (context) => const TravelPage(
              title: "Default Travel Guide",
              budget: 1500,
              days: 5,
            ),
      },
    );
  }
}