import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    UsersPage(),
    ProfessionalsListScreen(),
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
                      backgroundImage: NetworkImage(user['profileImage'] ?? ''),
                    ),
                    SizedBox(height: 10),
                    Text(
                      user['name'] ,
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


class ProfessionalsListScreen extends StatefulWidget {
  const ProfessionalsListScreen({super.key});

  @override
  _ProfessionalsListScreenState createState() => _ProfessionalsListScreenState();
}

class _ProfessionalsListScreenState extends State<ProfessionalsListScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Update approval status function
  Future<void> _updateProfessionalApproval(String professionalId, bool approve) async {
    await _firestore.collection('professionals').doc(professionalId).update({'approve': approve});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(approve ? "Professional approved" : "Professional rejected")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Professionals List"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('professionals').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No registered professionals found."));
          }

          List<DocumentSnapshot> professionals = snapshot.data!.docs;

          return ListView(
            children: professionals.map((professional) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: professional['profileImage'] != null && professional['profileImage'] != ''
                        ? NetworkImage(professional['profileImage'])
                        : const AssetImage('assets/default_profile.png') as ImageProvider,
                  ),
                  title: Text(
                    professional['name'] ?? 'No Name',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(professional['qualification'] ?? 'No Qualification'),
                      Text("Status: ${professional['approve'] ? "Approved" : "Pending"}"),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: () => _updateProfessionalApproval(professional.id, true),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () => _updateProfessionalApproval(professional.id, false),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
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
