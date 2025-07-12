import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mess/screens/dashboard_screen/dashboard_utils/meal_cards_utils.dart';
import 'package:mess/screens/dashboard_screen/dashboard_utils/name_of_meal_utils.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/model_bottom_sheet.dart';
import 'package:mess/extentions.dart';

final _mealData = getMealStatus(TimeOfDay.now());

final _currentMeal = _mealData['current']; // e.g. "Lunch"
final _otherMeals = _mealData['others'] ?? '';
// debugPrint('other meals: $_otherMeals');
final randomMeal1 = _otherMeals[0];
final randomMeal2 = _otherMeals[1];

String _mealTimingForCurrent() {
  if (_currentMeal == 'Breakfast') {
    return '7:00AM - 9:00AM';
  } else if (_currentMeal == 'Lunch') {
    return '12:00PM - 3:00PM';
  } else {
    return '7:00PM - 12:00PM';
  }
}

String _mealTimingForOther(String randomMeal) {
  if (randomMeal == 'Breakfast') {
    return '7:00 AM - 9:00 AM';
  } else if (randomMeal == 'Lunch') {
    return '12:00PM - 3:00PM';
  } else {
    return '7:00 PM-12:00 PM';
  }
}

class SymmetricalMealGrid extends StatelessWidget {
  final List<Meal> meals = [
    Meal(
        type: 'Breakfast',
        time: const TimeOfDay(hour: 8, minute: 0),
        isCurrent: false),
    Meal(
        type: '  Lunch  ',
        time: const TimeOfDay(hour: 13, minute: 0),
        isCurrent: true),
    Meal(
        type: ' Dinner      ',
        time: const TimeOfDay(hour: 20, minute: 0),
        isCurrent: false),
  ];

  SymmetricalMealGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth,
      height: screenHeight / 3.4,
      child: Row(
        spacing: 2,
        children: [
          // Main Large Card
          Expanded(child: _buildCurrentCard(context)),

          SizedBox(width: screenWidth * 0.0),

          // Two Stacked Small Cards
          SizedBox(
            width: screenWidth * 0.4,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
              child: Column(
                children: [
                  Expanded(
                      child: _buildSmallCard(_mealTimingForOther(randomMeal1),
                          randomMeal1, context)),
                  SizedBox(height: screenHeight * 0.01),
                  Expanded(
                      child: _buildSmallCard(_mealTimingForOther(randomMeal2),
                          randomMeal2, context)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentCard(BuildContext context) {
    final mealTiming = MealTiming().mealTiming();

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.015),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Centered Icon
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.white.applyOpacity(0.3),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.restaurant,
                color: Colors.white,
                size: 40,
              ),
            ),
            // SizedBox(height: 10),

            Text(
              _currentMeal,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
                fontFamily: GoogleFonts.lato().fontFamily,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                _mealTimingForCurrent(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const MealCountdown()
          ],
        ),
      ),
    );
  }

  Widget _buildSmallCard(timing, randomMeal, BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          // isScrollControlled: true,
          builder: (context) => buildModelBottomSheet(
            context,
            randomMeal,
            timing,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              randomMeal,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
                fontFamily: GoogleFonts.lato().fontFamily,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                timing,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMealDetails(Meal meal) {
    // Same as previous implementation
  }
}

class Meal {
  final String type;
  final TimeOfDay time;
  final bool isCurrent;

  Meal({
    required this.type,
    required this.time,
    required this.isCurrent,
  });
}
