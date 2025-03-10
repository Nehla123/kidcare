import 'package:flutter/material.dart';

class ProfessionalHomePage extends StatelessWidget {
  final String professionalName;

  const ProfessionalHomePage({super.key, required this.professionalName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, $professionalName!"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification click
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeBanner(),
            SizedBox(height: 20),
            _buildFeatureGrid(context),
            SizedBox(height: 20),
            Text("Recent Updates", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildRecentUpdate("New appointment request from Parent A."),
            _buildRecentUpdate("Message from Parent B: 'Need advice on child nutrition'"),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add_task),
        onPressed: () {
          // Handle quick task addition
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildWelcomeBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "Hello, $professionalName!\nYour next appointment is at 2:00 PM.",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _buildFeatureCard(Icons.calendar_today, "Appointments", context),
        _buildFeatureCard(Icons.chat, "Messages", context),
        _buildFeatureCard(Icons.task, "Tasks", context),
      ],
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to respective page
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

  Widget _buildBottomNavigation(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Colors.blueAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavButton(Icons.home, "Home", context), // Home icon remains the same
          _buildNavButton(Icons.reviews, "Reviews", context), // Added Review Icon
          _buildNavButton(Icons.person, "Profile", context), // Added Profile Icon
        ],
      ),
    );
  }

  Widget _buildNavButton(IconData icon, String label, BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      onPressed: () {
        // Navigate to respective section
      },
    );
  }
}
