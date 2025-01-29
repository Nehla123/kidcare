import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:animations/animations.dart';

class HomePage extends StatelessWidget {
  final String userName;

  HomePage({required this.userName});

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
            // Welcome Banner with Animation
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
              openBuilder: (context, action) => DetailsPage(title: "Welcome Info"),
            ),
            SizedBox(height: 20),

            // Animated Grid
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
                _buildFeatureCard(Icons.handshake, "Services", context),
                _buildFeatureCard(Icons.chat, "Community", context),
              ],
            ),
            SizedBox(height: 20),

            // Recent Updates with Animation
            Text("Recent Updates", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildRecentUpdate("Child reached a new milestone! 🎉"),
            _buildRecentUpdate("Upcoming vaccination reminder."),
            _buildRecentUpdate("New educational activity available."),
          ],
        ),
      ),
      
      // Bottom Navigation Bar with Buttons
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavButton(Icons.home, "Home", context),
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsPage(title: title)),
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsPage(title: label)),
        );
      },
    );
  }
}

// Placeholder for pages
class DetailsPage extends StatelessWidget {
  final String title;
  DetailsPage({required this.title});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text("Welcome to $title Page")),
    );
  }
}
