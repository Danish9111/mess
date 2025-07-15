import 'package:flutter/material.dart';
import 'meal_cards.dart';
import 'package:mess/extentions.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/attendance_ui/attendance_card.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/show_menu_suggestion_sheet.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  // Sample data - replace with your actual data source
  final String userName = "Nadeem";
  final int mealsTaken = 15;
  final int totalMeals = 21;
  final int missedMeals = 6;
  final double balance = 3250.0;
  final double attendancePercentage = 0.72;
  final String messStatus = "Dinner prep started";
  final String specialMessage = "Kheer served today 🥳🎉";
  DateTime nextMealTime =
      DateTime.now().add(const Duration(hours: 2, minutes: 15));

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          _buildWelcomeHeader(isSmallScreen),
          _buildAttendenceMarker(),
          const SizedBox(height: 24),
          _buildQuickActions(isSmallScreen, screenHeight),
          const SizedBox(height: 24),
          const HorizontalAttendanceBar(
            attendanceMap: {},
          ),
          const SizedBox(
            height: 10,
          ),
          _buildTodaysSpecial(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader(bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome, $userName 👋",
          style: TextStyle(
            fontSize: isSmallScreen ? 24 : 28,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey[800],
          ),
        ),
        // const SizedBox(height: 8),
        Text(
          _getDailyQuote(),
          style: TextStyle(
            fontSize: isSmallScreen ? 14 : 16,
            color: Colors.blueGrey[600],
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildAttendenceMarker() {
    return
        // In your dashboard:
        Column(
      children: [
        SymmetricalMealGrid(),
      ],
    );
  }

  Widget _buildQuickActions(bool isSmallScreen, screenHeight) {
    final actions = [
      {'icon': Icons.check_circle, 'label': 'Mark Meal'},
      {'icon': Icons.money_off, 'label': 'Request Refund'},
      {'icon': Icons.restaurant_menu, 'label': 'Suggest Menu'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Quick Actions",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blueGrey[800],
            )),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: actions.map((action) {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                        iconSize: isSmallScreen ? 32 : 36,
                        icon: Icon(action['icon'] as IconData,
                            color: Colors.lightBlue[800]),
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (_) => const Scaffold(
                              body: ShowMenuSuggestionSheet(),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 8),
                  Text(action['label'] as String,
                      style:
                          TextStyle(fontSize: 12, color: Colors.blueGrey[700]))
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTodaysSpecial() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Colors.lightBlue[100]!, Colors.lightBlue[200]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.lightBlue.applyOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Icon(Icons.star, color: Colors.amber[700], size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              specialMessage,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods
  String _getDailyQuote() {
    final quotes = [
      "Good food is the foundation of genuine happiness",
      "A balanced meal a day keeps the doctor away!",
      "Sharing meals makes them taste better",
      "Food is not just eating energy, it's an experience"
    ];
    return quotes[DateTime.now().day % quotes.length];
  }
}
