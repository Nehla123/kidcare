import 'package:flutter/material.dart';

class BookingDetailPage extends StatelessWidget {
  final String title;
  final String description;

  BookingDetailPage({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Your Service - $title"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            SizedBox(height: 20),

            Text("Available Time Slots", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildTimeSlot(context, "9:00 AM - 10:00 AM"),
            _buildTimeSlot(context, "10:00 AM - 11:00 AM"),
            _buildTimeSlot(context, "1:00 PM - 2:00 PM"),
            SizedBox(height: 20),

            Text("Enter Your Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildTextField("Full Name"),
            _buildTextField("Email"),
            _buildTextField("Phone Number"),
            SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Your booking has been confirmed!")),
                  );
                },
                child: Text("Confirm Booking"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlot(BuildContext context, String time) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(time),
        trailing: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("You selected $time")),
            );
          },
          child: Text("Select"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return TextField(
      decoration: InputDecoration(labelText: label),
    );
  }
}
