import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  List<Map<String, String>> discussions = [
    {"title": "Tips for Managing Toddler Tantrums", "author": "Sarah Johnson"},
    {"title": "Best Educational Toys for Infants", "author": "Michael Smith"},
    {"title": "When to Schedule First Dental Visit?", "author": "Dr. Emily Brown"},
  ];

  List<Map<String, String>> events = [
    {"event": "Parenting Workshop", "date": "Feb 25, 2025"},
    {"event": "Kids Nutrition Webinar", "date": "March 5, 2025"},
    {"event": "Local Parent Meetup", "date": "March 15, 2025"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Community Discussion Forum
            Text("Community Discussions", style: _sectionTitleStyle()),
            SizedBox(height: 10),
            _buildDiscussionList(),

            SizedBox(height: 20),

            // Upcoming Events
            Text("Upcoming Events", style: _sectionTitleStyle()),
            SizedBox(height: 10),
            _buildEventList(),

            SizedBox(height: 20),

            // Expert Advice Section
            Text("Expert Advice", style: _sectionTitleStyle()),
            SizedBox(height: 10),
            _buildExpertAdvice(),
          ],
        ),
      ),
    );
  }

  // Function to style section titles
  TextStyle _sectionTitleStyle() {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  }

  // Builds the discussion list
  Widget _buildDiscussionList() {
    return Column(
      children: discussions.map((discussion) {
        return Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: Icon(Icons.forum, color: Colors.blueAccent),
            title: Text(discussion["title"]!),
            subtitle: Text("By: ${discussion["author"]}"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to discussion details
            },
          ),
        );
      }).toList(),
    );
  }

  // Builds the event list
  Widget _buildEventList() {
    return Column(
      children: events.map((event) {
        return Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: Icon(Icons.event, color: Colors.green),
            title: Text(event["event"]!),
            subtitle: Text("Date: ${event["date"]}"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to event details
            },
          ),
        );
      }).toList(),
    );
  }

  // Expert Advice Section
  Widget _buildExpertAdvice() {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(Icons.health_and_safety, color: Colors.redAccent),
        title: Text("Ask an Expert"),
        subtitle: Text("Get advice from pediatricians, educators, and psychologists."),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Navigate to expert advice section
        },
      ),
    );
  }
}
