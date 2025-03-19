import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  double _rating = 0;
  TextEditingController _feedbackController = TextEditingController();
  bool _hasFeedback = false; // Track if user has given feedback

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Feedback"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "We value your feedback!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Rate your experience:"),
            SizedBox(height: 10),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            SizedBox(height: 20),
            Text("Share your experience:"),
            SizedBox(height: 10),
            TextField(
              controller: _feedbackController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Write your feedback here...",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            _hasFeedback
                ? Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _hasFeedback = false;
                            _feedbackController.clear();
                            _rating = 0;
                          });
                        },
                        child: Text("Edit Feedback"),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Handle update action
                        },
                        child: Text("Update Feedback"),
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _hasFeedback = true;
                      });
                      // Handle feedback submission
                      print("Rating: $_rating");
                      print("Feedback: ${_feedbackController.text}");
                    },
                    child: Text("Submit Feedback"),
                  ),
          ],
        ),
      ),
    );
  }
}
