
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kidcare/admin/adminhomepage.dart';
import 'package:kidcare/professional/professional%20homepage.dart';
import 'package:kidcare/user/user%20homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String email = '';
  String password = '';
  bool passwordVisible = false;

  final String adminEmail = "admin@kidscare.com";
  final String adminPassword = "admin123";

  bool isLoading = false;

  Future<void> _login() async {
  if (_formKey.currentState!.validate()) {
    setState(() {
      isLoading = true;
    });
    _formKey.currentState!.save();

    try {
     
      if (email == adminEmail && password == adminPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Admin login successful")),
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AdminDashboard()));
        return;
      }
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;
      DocumentSnapshot professionalDoc = await _firestore.collection('professionals').doc(uid).get();
      if (professionalDoc.exists) {
        bool isApproved = professionalDoc['approved'];
        if (!isApproved) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("No permission to login. Please contact admin.")),
          );
          return;
        } else {
          String professionalName = professionalDoc['name'] ?? '';

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Professional login successful")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => ProfessionalHomePage(professionalName: professionalName)),
          );
          return;
        }
      }

     
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        String userName = userDoc['name'] ?? '';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User login successful")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage(userName: userName)),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No user data found.")),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Login Error")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 31, 15, 150), Color.fromARGB(248, 182, 180, 239)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Card(
                color: Colors.white,
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Login to KIDSCARE",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: "Email",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          validator: (value) => value!.isEmpty ? "Enter email" : null,
                          onSaved: (value) => email = value!,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: "Password",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                          ),
                          obscureText: !passwordVisible,
                          validator: (value) => value!.isEmpty ? "Enter password" : null,
                          onSaved: (value) => password = value!,
                        ),
                        SizedBox(height: 24),
                        isLoading
                            ? CircularProgressIndicator()
                            : GestureDetector(
                                onTap: _login,
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.orange, Colors.deepOrange],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(8),
                child: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}