import 'package:flutter/material.dart';
import 'package:kidcare/user/bookingdetailpage.dart';


class ServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Services"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Available Services", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            
            _buildServiceCategory(context, Icons.local_hospital, "Medical Services", 
                "Book doctor appointments, health checkups, and emergency services."),
            _buildServiceCategory(context, Icons.school, "Educational Support", 
                "Find tutors, learning materials, and online workshops."),
            _buildServiceCategory(context, Icons.group, "Community & Social", 
                "Join parent groups, counseling, and daycare services."),
            _buildServiceCategory(context, Icons.gavel, "Legal & Government", 
                "Learn about child safety laws, financial aid, and legal rights."),
            _buildServiceCategory(context, Icons.child_care, "Childcare & Miscellaneous", 
                "Find baby products, parenting tips, and event notifications."),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCategory(BuildContext context, IconData icon, String title, String description) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent, size: 40),
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        trailing: ElevatedButton(
          onPressed: () {
            // Navigate to BookingDetailPage with title & description
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingDetailPage(title: title, description: description),
              ),
            );
          },
          child: Text("Book Now"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
        ),
      ),
    );
  }
}
