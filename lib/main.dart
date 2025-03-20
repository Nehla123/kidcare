import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kidcare/firebase_options.dart';
import 'package:kidcare/slashscreen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Add this line before Firebase initialization

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
      title: 'KidCare',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Ensure this is properly imported
    );
  }
}
