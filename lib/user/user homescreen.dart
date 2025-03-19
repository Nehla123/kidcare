import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:animations/animations.dart';
import 'package:kidcare/admin/adminhomepage.dart';
import 'package:kidcare/user/communitypage.dart';
import 'package:kidcare/user/development.dart';
import 'package:kidcare/user/education%20page%20.dart';
import 'package:kidcare/user/health%20page.dart';
import 'package:kidcare/user/profilepage.dart';
import 'package:kidcare/user/servicespage.dart';

class HomePage extends StatelessWidget {
  final String userName;

  const HomePage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, $userName!"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OpenContainer(
              closedElevation: 0,
              closedColor: Colors.blueAccent,
              closedBuilder: (context, action) => Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Hello, $userName!\nHow's your child doing today?",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              openBuilder: (context, action) => Container(),
            ),
            SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildFeatureCard(Icons.child_friendly, "Development", context),
                _buildFeatureCard(Icons.health_and_safety, "Health", context),
                _buildFeatureCard(Icons.book, "Education", context),
              ],
            ),
            SizedBox(height: 20),
            Text("Recent Updates", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildRecentUpdate("Child reached a new milestone! 🎉"),
            _buildRecentUpdate("Upcoming vaccination reminder."),
            _buildRecentUpdate("New educational activity available."),
            SizedBox(height: 20),
            ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeedbackPage()),
        );
       },
         child: Text("Give Feedback"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            _buildNavButton(Icons.person, "Profile", context),
            _buildNavButton(Icons.support, "Services", context),
            _buildNavButton(Icons.people, "Community", context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Widget page;
        switch (title) {
          case "Development":
            page = DevelopmentPage();
            break;
          case "Health":
            page = HealthPage();
            break;
          case "Education":
            page = EducationPage();
            break;
          default:
            page = Container();
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blueAccent),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentUpdate(String update) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(Icons.notifications, color: Colors.blueAccent),
        title: Text(update),
      ),
    );
  }

  Widget _buildNavButton(IconData icon, String label, BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      onPressed: () {
        Widget page;
        switch (label) {
          case "Profile":
            page = ProfilePage();
            break;
          case "Services":
            page = ServicesPage();
            break;
          case "Community":
            page = CommunityPage();
            break;
          case "Give Feedback":
            page = FeedbackPage();
            break;  
          default:
            page = Container();
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}
