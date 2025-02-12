import 'package:flutter/material.dart';

class EducationPage extends StatelessWidget {
  const EducationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Education - Learning Activities"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("📖 Reading & Storytelling"),
            _buildActivityCard("Interactive Stories", "Listen to fun and engaging stories with animations!", Icons.book, Colors.orange),
            _buildActivityCard("Picture Books", "Explore colorful picture books to boost early reading skills.", Icons.menu_book, Colors.red),
            
            _buildSectionTitle("🔢 Math & Logical Thinking"),
            _buildActivityCard("Counting Games", "Learn numbers with fun interactive exercises.", Icons.exposure, Colors.green),
            _buildActivityCard("Pattern Recognition", "Identify and complete patterns with shapes and colors.", Icons.extension, Colors.blue),
            
            _buildSectionTitle("🔬 Science & Exploration"),
            _buildActivityCard("Simple Science Experiments", "Try easy at-home experiments to learn science concepts!", Icons.science, Colors.purple),
            _buildActivityCard("Animal & Nature Learning", "Discover fun facts about animals and nature.", Icons.eco, Colors.brown),
            
            _buildSectionTitle("🎨 Creative & Art-Based Activities"),
            _buildActivityCard("Coloring Pages", "Enjoy digital and printable coloring activities.", Icons.color_lens, Colors.pink),
            _buildActivityCard("Music & Rhymes", "Sing along with fun nursery rhymes.", Icons.music_note, Colors.teal),
            
            _buildSectionTitle("💡 Life Skills & Emotional Intelligence"),
            _buildActivityCard("Social Skills Training", "Learn kindness, sharing, and teamwork.", Icons.handshake, Colors.deepPurple),
            _buildActivityCard("Basic Hygiene & Safety", "Understand the importance of cleanliness and safety.", Icons.health_and_safety, Colors.deepOrange),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
      ),
    );
  }

  Widget _buildActivityCard(String title, String description, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, size: 40, color: color),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: () {}, // Here you can navigate to detailed pages for each activity
      ),
    );
  }
}
