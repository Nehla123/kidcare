import 'package:flutter/material.dart';

class HealthyEatingPage extends StatelessWidget {
  final double bmi;
  final int age;

  const HealthyEatingPage({super.key, required this.bmi, required this.age});

  String getNutritionPlan() {
    if (age < 2) {
      return "1. **Breastfeeding/Formula:** Continue breastfeeding or formula feeding as the primary source of nutrition.\n\n"
             "2. **Introducing Solids:** At around 6 months, start pureed vegetables, fruits, and iron-rich foods.\n\n"
             "3. **Iron and Protein:** Include mashed beans, lentils, eggs, and soft meats for growth.\n\n"
             "4. **Healthy Fats:** Avocados, full-fat yogurt, and nut butter (if no allergies) support brain development.";
    } else if (age < 5) {
      if (bmi < 18.5) {
        return "1. **Increase Caloric Intake:** Provide foods rich in healthy fats like cheese, nuts, and olive oil.\n\n"
               "2. **Protein-Rich Diet:** Include eggs, lean meats, and dairy to support muscle growth.\n\n"
               "3. **Whole Grains:** Brown rice, whole wheat bread, and oats provide long-lasting energy.\n\n"
               "4. **Frequent Meals:** Offer 5-6 small meals/snacks throughout the day.";
      } else if (bmi < 24.9) {
        return "1. **Balanced Meals:** Serve fruits, vegetables, proteins, and whole grains in every meal.\n\n"
               "2. **Limit Processed Foods:** Reduce intake of sugary snacks and processed meals.\n\n"
               "3. **Hydration:** Encourage water over sugary drinks and sodas.\n\n"
               "4. **Healthy Snacking:** Offer yogurt, fruit slices, and homemade smoothies instead of chips or candy.";
      } else {
        return "1. **Reduce Sugar Intake:** Avoid candies, soda, and excessive fruit juices.\n\n"
               "2. **Fiber-Rich Diet:** Include whole grains, vegetables, and beans for better digestion.\n\n"
               "3. **More Fruits & Vegetables:** Half of the plate should be colorful fruits and veggies.\n\n"
               "4. **Encourage Physical Activity:** Promote outdoor play and active movement.";
      }
    } else if (age < 12) {
      if (bmi < 18.5) {
        return "1. **Increase Portions:** Ensure the child eats larger portions of nutrient-dense foods.\n\n"
               "2. **Energy-Dense Foods:** Provide peanut butter, eggs, and whole dairy for extra calories.\n\n"
               "3. **Frequent Snacking:** Offer healthy snacks like cheese cubes, nuts, and hummus with whole-grain crackers.\n\n"
               "4. **Protein Boost:** Add chicken, fish, or plant-based proteins to meals to aid muscle development.";
      } else if (bmi < 24.9) {
        return "1. **Healthy Home Meals:** Prepare home-cooked meals using fresh ingredients to avoid preservatives.\n\n"
               "2. **Balanced Diet:** Ensure equal portions of protein, carbs, and vegetables.\n\n"
               "3. **Water Over Sugary Drinks:** Encourage 6-8 glasses of water per day.\n\n"
               "4. **Nutritious Snacks:** Choose granola, fruit, and boiled eggs over processed snacks.";
      } else {
        return "1. **Smaller Portions:** Serve appropriate portions to prevent overeating.\n\n"
               "2. **Lean Proteins:** Include fish, chicken, tofu, and beans in meals.\n\n"
               "3. **More Fiber:** Opt for whole grains like quinoa and whole-wheat pasta.\n\n"
               "4. **Daily Exercise:** Encourage 60 minutes of physical activity daily, like sports or outdoor play.";
      }
    } else {
      if (bmi < 18.5) {
        return "1. **Increase Calories:** Provide nutrient-dense foods like nut butters, milkshakes, and whole grains.\n\n"
               "2. **High-Protein Diet:** Eggs, lean meats, and legumes help in muscle and bone development.\n\n"
               "3. **Healthy Fats:** Add sources like olive oil, nuts, and seeds to meals.\n\n"
               "4. **Frequent Eating:** Ensure three main meals with at least two healthy snacks daily.";
      } else if (bmi < 24.9) {
        return "1. **Portion Control:** Maintain balanced portions with vegetables, protein, and whole grains.\n\n"
               "2. **Nutrient-Rich Foods:** Prefer fresh fruits, lean meats, and whole foods.\n\n"
               "3. **Hydration:** Drink plenty of water and limit sugary drinks.\n\n"
               "4. **Active Lifestyle:** Encourage walking, cycling, or any physical activity regularly.";
      } else {
        return "1. **Reduce Processed Foods:** Cut down on fried and high-calorie fast foods.\n\n"
               "2. **Healthy Snacks:** Replace chips and candy with fruits, yogurt, and nuts.\n\n"
               "3. **Increase Physical Activity:** Aim for at least one hour of exercise daily.\n\n"
               "4. **Meal Planning:** Plan healthy meals in advance to avoid unhealthy choices.";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Healthy Eating & Nutrition"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Age-Based Nutrition Plan",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 10),
            Text(
              getNutritionPlan(),
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
