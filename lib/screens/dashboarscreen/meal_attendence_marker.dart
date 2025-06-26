import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SymmetricalMealGrid extends StatelessWidget {
  final List<Meal> meals = [
    Meal(
        type: 'Breakfast',
        time: TimeOfDay(hour: 8, minute: 0),
        isCurrent: false),
    Meal(
        type: '  Lunch  ',
        time: TimeOfDay(hour: 13, minute: 0),
        isCurrent: true),
    Meal(
        type: ' Dinner      ',
        time: TimeOfDay(hour: 20, minute: 0),
        isCurrent: false),
  ];

  SymmetricalMealGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight / 3.4,
      child: Row(
        spacing: 1,
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
                  Expanded(child: _buildSmallCard('Breakfast')),
                  SizedBox(height: screenHeight * 0.01),
                  Expanded(child: _buildSmallCard('Dinner')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentCard(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                Icons.restaurant,
                color: Colors.white,
                size: 40,
              ),
            ),
            // SizedBox(height: 10),

            Text(
              "Lunch",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
                fontFamily: GoogleFonts.lato().fontFamily,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                'Currently Serving',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text(
              'Closing in 20 minutes',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallCard(String meal) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            meal,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
              fontFamily: GoogleFonts.lato().fontFamily,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              'Currently Serving',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
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
