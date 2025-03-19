import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kidcare/admin/adminhomepage.dart';
import 'package:kidcare/professional/professional%20homepage.dart';
import 'package:kidcare/user/user%20forgotpage.dart';
import 'package:kidcare/user/user%20homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isPasswordVisible = false;

  // Login User Function
  void _loginUser() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("Please fill all fields");
      return;
    }

    try {
      // Check for Admin Login
      if (email == "nehla@gmail.com" && password == "Nehla.123") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AdminPanel(),
          ),
        );
        return;
      }

      // Sign in with Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Fetch User Role from Firestore
      String userRole = await _fetchUserRole(userCredential.user!.uid);

      // Navigate to Appropriate Home Page
      if (userRole == 'user') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(userName: ''),
          ),
        );
      } else if (userRole == 'professional') {
        bool isApproved = await _checkProfessionalApproval(userCredential.user!.uid);

        if (isApproved) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ProfessionalHomePage(professionalName: ''),
            ),
          );
        } else {
          _showSnackBar("Your account is not approved yet. Please contact support.");
        }
      } else {
        _showSnackBar("Unknown role. Please contact support.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showSnackBar("No user found for this email.");
      } else if (e.code == 'wrong-password') {
        _showSnackBar("Incorrect password.");
      } else {
        _showSnackBar(e.message ?? "An error occurred");
      }
    } catch (e) {
      _showSnackBar("An unexpected error occurred");
    }
  }

  // Fetch User Role from Firestore
  Future<String> _fetchUserRole(String userId) async {
    try {
      // Check in users collection
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userDoc.exists && userDoc['role'] != null) {
        return userDoc['role'];
      }

      // Check in professionals collection
      DocumentSnapshot professionalDoc = await FirebaseFirestore.instance
          .collection('professionals')
          .doc(userId)
          .get();
      if (professionalDoc.exists && professionalDoc['role'] != null) {
        return professionalDoc['role'];
      }

      return "user";
    } catch (e) {
      return "user";
    }
  }

  // Check Professional Approval Status
  Future<bool> _checkProfessionalApproval(String professionalId) async {
    try {
      DocumentSnapshot professionalsDoc = await FirebaseFirestore.instance
          .collection('professionals')
          .doc(professionalId)
          .get();
      if (professionalsDoc.exists) {
        return professionalsDoc['approved'] ?? false;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Show SnackBar for Messages
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Login",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade800, Colors.lightBlue.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Login Form
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 120),
                // Email Field
                _buildTextField(
                  controller: _emailController,
                  label: 'Email Address',
                  hintText: 'Enter your email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                // Password Field
                _buildPasswordField(
                  controller: _passwordController,
                  label: 'Password',
                  hintText: 'Enter your password',
                  icon: Icons.lock,
                ),
                SizedBox(height: 30),
                // Login Button
                ElevatedButton(
                  onPressed: _loginUser,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 80.0),
                    backgroundColor: Colors.deepOrangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text("Login"),
                ),
                SizedBox(height: 20),
                // Forgot Password
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Custom TextField Widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.deepOrange),
        labelText: label,
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );
  }

  // Password Field with Show/Hide Icon
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
  }) {
    return _buildTextField(
      controller: controller,
      label: label,
      hintText: hintText,
      icon: icon,
      obscureText: !_isPasswordVisible,
    );
  }
}
