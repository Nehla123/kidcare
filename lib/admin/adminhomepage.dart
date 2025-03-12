import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AdminPanel());
}

class AdminPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
      home: AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    UsersPage(),
    ProfessionalsPage(),
    AppointmentsPage(),
    ContentModerationPage(),
    FeedbackPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Dashboard")),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Professionals'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Appointments'),
          BottomNavigationBarItem(icon: Icon(Icons.security), label: 'Moderation'),
          BottomNavigationBarItem(icon: Icon(Icons.feedback), label: 'Feedback'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

// User Management Page
class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        return GridView.builder(
          padding: EdgeInsets.all(10.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.9,
          ),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var user = snapshot.data!.docs[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(user['profileImageUrl'] ?? ''),
                    ),
                    SizedBox(height: 10),
                    Text(
                      user['firstName'] + ' ' + user['lastName'],
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5),
                    Text(user['email'], style: TextStyle(fontSize: 14), textAlign: TextAlign.center),
                    SizedBox(height: 5),
                    Text("DOB: ${user['dob']}", style: TextStyle(fontSize: 14), textAlign: TextAlign.center),
                    SizedBox(height: 5),
                    Text("Phone: ${user['phone']}", style: TextStyle(fontSize: 14), textAlign: TextAlign.center),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}


// Professional Management Page
class ProfessionalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('professionals').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        return ListView(
          children: snapshot.data!.docs.map((professional) {
            return ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(professional['profileImage'] ?? '')),
              title: Text(professional['name']),
              subtitle: Text(professional['qualification']),
            );
          }).toList(),
        );
      },
    );
  }
}

// Appointments Management Page
class AppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Appointments & Booking Management"));
  }
}

// Content Moderation Page
class ContentModerationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Content & Community Moderation"));
  }
}

// Feedback Page
class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('feedback').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        return ListView(
          children: snapshot.data!.docs.map((feedback) {
            return ListTile(
              title: Text(feedback['email']),
              subtitle: Text(feedback['message']),
            );
          }).toList(),
        );
      },
    );
  }
}
