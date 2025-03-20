import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kidcare/user/editprofilescreen.dart';
import 'package:kidcare/login.dart';

class ProfilePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Profile")),
        body: Center(child: Text("No user signed in")),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF3F2B96),
              Color(0xFFA8C0FF),
            ],
          ),
        ),
        child: FutureBuilder<DocumentSnapshot>(
          future: _firestore.collection('users').doc(user.uid).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error fetching user data"));
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(child: Text("User data not found"));
            }

            var userData = snapshot.data!.data() as Map<String, dynamic>;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Your Profile",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 24),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: userData['profileImage'] != null
                        ? NetworkImage(userData['profileImage'])
                        : AssetImage('assets/default_profile.png') as ImageProvider,
                  ),
                  SizedBox(height: 20),
                  _buildProfileField("Full Name", userData['name'] ?? 'N/A'),
                  _buildProfileField("Email", userData['email'] ?? 'N/A'),
                  _buildProfileField("Phone", userData['phone'] ?? 'N/A'),
                  _buildProfileField("Date of Birth", userData['dob'] ?? 'N/A'),
                  SizedBox(height: 30),
                  _buildButton(context, "Edit Profile", Icons.edit, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(userId: user.uid),
                      ),
                    );
                  }),
                  SizedBox(height: 16),
                  _buildButton(context, "Logout", Icons.logout, () async {
                    await _auth.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) =>LoginScreen ()),
                      (Route<dynamic> route) => false,
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "$label: $value",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, IconData icon, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFA726),
            Color(0xFFFF7043),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white),
        label: Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
