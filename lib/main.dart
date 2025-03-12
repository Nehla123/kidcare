import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kidcare/admin/adminhomepage.dart';
import 'package:kidcare/admin/adminlogin.dart';
import 'package:kidcare/choosescreen.dart';
import 'package:kidcare/firebase_options.dart';
import 'package:kidcare/professional/professional%20homepage.dart';
import 'package:kidcare/professional/professional%20login.dart';
import 'package:kidcare/professional/professional%20signup%20screen.dart';
import 'package:kidcare/slashscreen.dart';
import 'package:kidcare/user/bookingdetailpage.dart';
import 'package:kidcare/user/communitypage.dart';
import 'package:kidcare/user/growth_milestones_page.dart';
import 'package:kidcare/user/healthy_eating_page.dart';
import 'package:kidcare/user/profilepage.dart';
import 'package:kidcare/user/servicespage.dart';
import 'package:kidcare/user/user%20homescreen.dart';
import 'package:kidcare/user/user%20signup%20screen.dart';
import 'package:kidcare/professional_login_screen.dart';
import 'package:kidcare/user/userlogin.dart'; // Ensure this is the correct path

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
      home: AdminDashboard(), // Ensure this is properly imported
    );
  }
}
