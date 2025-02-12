import 'package:flutter/material.dart';

class HealthPage extends StatelessWidget {
  const HealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health & Well-Being"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader("Growth & Nutrition"),
            _buildListTile("Growth Milestones", "Track your child’s height, weight & BMI", Icons.timeline),
            _buildListTile("Healthy Eating", "Age-based nutrition & meal plans", Icons.restaurant),
            _buildListTile("Feeding Advice", "Breastfeeding, formula, and solid food tips", Icons.local_dining),
            
            _buildSectionHeader("Vaccination Schedule"),
            _buildListTile("Immunization Chart", "Age-wise vaccination schedule", Icons.local_hospital),
            _buildListTile("Vaccine Reminders", "Set reminders for upcoming vaccines", Icons.notifications_active),
            
            _buildSectionHeader("Common Illnesses & Remedies"),
            _buildListTile("Cold & Flu", "Symptoms & home remedies", Icons.sick),
            _buildListTile("Ear Infections", "How to manage and prevent", Icons.hearing),
            _buildListTile("Stomach Issues", "Diarrhea, vomiting, and dehydration", Icons.medical_services),
            
            _buildSectionHeader("Mental & Emotional Health"),
            _buildListTile("Managing Stress", "How to handle childhood anxiety", Icons.psychology),
            _buildListTile("Behavioral Issues", "Dealing with tantrums & emotions", Icons.sentiment_satisfied_alt),
            
            _buildSectionHeader("First Aid & Safety"),
            _buildListTile("Emergency First Aid", "Basic steps for injuries & choking", Icons.health_and_safety),
            _buildListTile("Home Safety", "Tips to childproof your home", Icons.home),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
      ),
    );
  }

  Widget _buildListTile(String title, String subtitle, IconData icon) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
        onTap: () {
          // Navigate to detailed page if needed
        },
      ),
    );
  }
}
