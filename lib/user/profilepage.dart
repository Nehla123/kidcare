import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kidcare/user/editprofilescreen.dart';
import 'package:kidcare/user/userlogin.dart';


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
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigate to EditProfilePage and pass userId
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(userId: user.uid),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
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

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: userData['profileImageUrl'] != null
                        ? NetworkImage(userData['profileImageUrl'])
                        : AssetImage('assets/default_profile.png') as ImageProvider,
                  ),
                ),
                SizedBox(height: 20),
                Text("Name: ${userData['firstName'] ?? 'N/A'} ${userData['lastName'] ?? ''}",
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text("Email: ${userData['email'] ?? 'N/A'}", style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Text("Phone: ${userData['phone'] ?? 'N/A'}", style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Text("DOB: ${userData['dob'] ?? 'N/A'}", style: TextStyle(fontSize: 16)),
                Spacer(),
               Center(
  child: ElevatedButton.icon(
    onPressed: ()  {
  
        // Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute(builder: (context) => ()),
        //   (Route<dynamic> route) => false,
        // );

    },
    icon: Icon(Icons.logout),
    label: Text("Logout"),
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
    ),
  ),
),

              ],
            ),
          );
        },
      ),
    );
  }
}
