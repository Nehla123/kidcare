import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kidcare/choosescreen.dart';
import 'package:kidcare/firebase_options.dart';
import 'package:kidcare/user/bookingdetailpage.dart';
import 'package:kidcare/user/communitypage.dart';
import 'package:kidcare/user/profilepage.dart';
import 'package:kidcare/user/servicespage.dart';
import 'package:kidcare/user/user%20homescreen.dart';
import 'package:kidcare/user/user%20signup%20screen.dart';

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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChooseScreen(), // Replace "Default Name" with actual user data(), // ✅ Ensure this is properly imported
    );
  }
}
