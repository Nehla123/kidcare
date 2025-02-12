import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DevelopmentPage extends StatelessWidget {
  const DevelopmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Child Development"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Milestones", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              _buildMilestones(),
              SizedBox(height: 20),
              Text("Growth Chart", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              _buildGrowthChart(),
              SizedBox(height: 20),
              Text("Activity Suggestions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              _buildActivitySuggestions(),
              SizedBox(height: 20),
              Text("Parental Tips", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              _buildParentalTips(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMilestones() {
    List<String> milestones = ["First Smile", "First Words", "First Steps", "Started Crawling", "First Solid Food"];
    return Column(
      children: milestones.map((milestone) => ListTile(
        leading: Icon(Icons.check_circle, color: Colors.green),
        title: Text(milestone),
      )).toList(),
    );
  }

  Widget _buildGrowthChart() {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: [FlSpot(1, 50), FlSpot(3, 58), FlSpot(6, 66), FlSpot(12, 74)],
              isCurved: true,
              color: Colors.blueAccent,
              barWidth: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivitySuggestions() {
    List<String> activities = ["Tummy Time Exercises", "Reading Short Stories", "Sensory Play", "Music and Dancing"];
    return Column(
      children: activities.map((activity) => ListTile(
        leading: Icon(Icons.lightbulb, color: Colors.orange),
        title: Text(activity),
      )).toList(),
    );
  }

  Widget _buildParentalTips() {
    List<String> tips = [
      "Talk to your child regularly to encourage language skills.",
      "Provide a safe space for movement and exploration.",
      "Encourage independent play to develop problem-solving skills."
    ];
    return Column(
      children: tips.map((tip) => ListTile(
        leading: Icon(Icons.info, color: Colors.blueAccent),
        title: Text(tip),
      )).toList(),
    );
  }
}
