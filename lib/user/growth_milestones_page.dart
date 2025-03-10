import 'package:flutter/material.dart';

class GrowthMilestonesPage extends StatefulWidget {
  const GrowthMilestonesPage({super.key});

  @override
  _GrowthMilestonesPageState createState() => _GrowthMilestonesPageState();
}

class _GrowthMilestonesPageState extends State<GrowthMilestonesPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  double? bmi;

  void _calculateBMI() {
    double height = double.tryParse(heightController.text) ?? 0;
    double weight = double.tryParse(weightController.text) ?? 0;
    if (height > 0 && weight > 0) {
      setState(() {
        bmi = weight / ((height / 100) * (height / 100));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Growth Tracking"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader("Enter Child's Details"),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Child's Name"),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: "Age (years)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: heightController,
              decoration: InputDecoration(labelText: "Height (cm)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: weightController,
              decoration: InputDecoration(labelText: "Weight (kg)"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _calculateBMI,
              child: Text("Calculate BMI"),
            ),
            if (bmi != null) ...[
              SizedBox(height: 20),
              _buildSectionHeader("Results"),
              Text("BMI: ${bmi!.toStringAsFixed(2)}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(_bmiCategory(), style: TextStyle(fontSize: 16, color: Colors.blueAccent)),
            ],
          ],
        ),
      ),
    );
  }

  String _bmiCategory() {
    if (bmi == null) return "";
    if (bmi! < 18.5) return "Underweight";
    if (bmi! < 24.9) return "Healthy Weight";
    if (bmi! < 29.9) return "Overweight";
    return "Obese";
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
}
