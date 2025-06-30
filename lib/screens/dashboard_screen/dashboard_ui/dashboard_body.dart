import 'package:flutter/material.dart';
import 'meal_cards.dart';
import 'package:mess/extentions.dart';

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

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          _buildWelcomeHeader(isSmallScreen),
          _buildAttendenceMarker(),
          _buildMealProgress(),
          const SizedBox(height: 24),
          _buildMessStatusCard(),
          const SizedBox(height: 24),
          _buildQuickActions(isSmallScreen),
          const SizedBox(height: 24),
          _buildTodaysSpecial(),
          SizedBox(height: 24),
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

  Widget _buildStatsGrid(bool isSmallScreen) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isSmallScreen ? 1 : 3,
      childAspectRatio: isSmallScreen ? 3.5 : 1.5,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildStatCard(
            "Meals Taken", "$mealsTaken/$totalMeals", Icons.restaurant),
        _buildStatCard("Missed Meals", "$missedMeals", Icons.no_meals),
        _buildStatCard("Balance Left", "₹${balance.toStringAsFixed(0)}",
            Icons.account_balance_wallet),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.lightBlue[100],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.lightBlue[800]),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: TextStyle(color: Colors.blueGrey[600])),
              const SizedBox(height: 4),
              Text(value,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
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

  Widget _buildMealProgress() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.lightBlue[50]!, Colors.lightBlue[100]!],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Meal Attendance",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    )),
                Text("${(attendancePercentage * 100).toInt()}%",
                    style: TextStyle(
                        color: Colors.lightBlue[800],
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: attendancePercentage,
              minHeight: 12,
              backgroundColor: Colors.lightBlue[100],
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessStatusCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.applyOpacity(0.7),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.applyOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Mess Status",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blueGrey[800],
                    )),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(messStatus,
                      style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildCountdownTimer(),
          ],
        ),
      ),
    );
  }

  Widget _buildCountdownTimer() {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        final now = DateTime.now();
        final difference = nextMealTime.difference(now);
        final hours = difference.inHours;
        final minutes = difference.inMinutes.remainder(60);

        return Row(
          children: [
            Icon(Icons.access_time, color: Colors.lightBlue[700]),
            const SizedBox(width: 8),
            Text(
              "Next meal in ",
              style: TextStyle(color: Colors.blueGrey[700]),
            ),
            Text(
              "${hours}h ${minutes}m",
              style: TextStyle(
                color: Colors.lightBlue[800],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildQuickActions(bool isSmallScreen) {
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
        Row(
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
                    onPressed: () => _handleAction(action['label'] as String),
                  ),
                ),
                const SizedBox(height: 8),
                Text(action['label'] as String,
                    style: TextStyle(fontSize: 12, color: Colors.blueGrey[700]))
              ],
            );
          }).toList(),
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

  Color _getStatusColor() {
    switch (messStatus) {
      case "Open":
        return Colors.green;
      case "Closed":
        return Colors.red;
      case "Dinner prep started":
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  void _handleAction(String action) {
    // Add your action handling logic here
    print("Action selected: $action");
  }
}
