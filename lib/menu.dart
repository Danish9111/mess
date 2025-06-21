import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MessMealPlannerApp());

class MessMealPlannerApp extends StatelessWidget {
  const MessMealPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mess Meal Planner',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 228, 243, 229),
          // textTheme: GoogleFonts.poppinsTextTheme(),
        ),
      ),
      home: const MealPlannerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MealPlannerScreen extends StatefulWidget {
  const MealPlannerScreen({super.key});

  @override
  State<MealPlannerScreen> createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> {
  final List<DayMeals> _weeklyMenu = [
    DayMeals(
      day: 'Monday',
      breakfast: Meal(name: 'Pancakes', votes: 24, userVote: 0),
      lunch: Meal(name: 'Chicken Biryani', votes: 42, userVote: 1),
      dinner: Meal(name: 'Pasta Alfredo', votes: 18, userVote: -1),
    ),
    DayMeals(
      day: 'Tuesday',
      breakfast: Meal(name: 'Idli-Sambar', votes: 38, userVote: 0),
      lunch: Meal(name: 'Rajma Chawal', votes: 35, userVote: 0),
      dinner: Meal(name: 'Vegetable Stir Fry', votes: 27, userVote: 0),
    ),
    // Add remaining days...
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Meal Planner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildMealPlanner(isMobile),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton.extended(
              onPressed: _showMealSuggestionDialog,
              icon: const Icon(Icons.lightbulb_outline),
              label: const Text('Suggest a Meal'),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealPlanner(bool isMobile) {
    return isMobile ? _buildMobileList() : _buildDesktopGrid();
  }

  Widget _buildMobileList() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: _weeklyMenu.length,
      itemBuilder: (context, index) {
        return _dayCardMobile(_weeklyMenu[index]);
      },
    );
  }

  Widget _buildDesktopGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16).copyWith(bottom: 80),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: _weeklyMenu.length,
      itemBuilder: (context, index) {
        return _dayCardDesktop(_weeklyMenu[index]);
      },
    );
  }

  Widget _dayCardMobile(DayMeals dayMeals) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ExpansionTile(
        title: Text(
          dayMeals.day,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          _mealTile(dayMeals.breakfast, 'Breakfast', Icons.breakfast_dining),
          _mealTile(dayMeals.lunch, 'Lunch', Icons.lunch_dining),
          _mealTile(dayMeals.dinner, 'Dinner', Icons.dinner_dining),
        ],
      ),
    );
  }

  Widget _dayCardDesktop(DayMeals dayMeals) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        hoverColor: Colors.green.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dayMeals.day,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              _mealCard(
                  dayMeals.breakfast, 'Breakfast', Icons.breakfast_dining),
              _mealCard(dayMeals.lunch, 'Lunch', Icons.lunch_dining),
              _mealCard(dayMeals.dinner, 'Dinner', Icons.dinner_dining),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mealTile(Meal meal, String type, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(meal.name),
      subtitle: Text('${meal.votes} votes'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              Icons.thumb_up,
              color: meal.userVote == 1 ? Colors.green : Colors.grey,
            ),
            onPressed: () => _handleVote(meal, 1),
          ),
          IconButton(
            icon: Icon(
              Icons.thumb_down,
              color: meal.userVote == -1 ? Colors.red : Colors.grey,
            ),
            onPressed: () => _handleVote(meal, -1),
          ),
        ],
      ),
    );
  }

  Widget _mealCard(Meal meal, String type, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.green),
              const SizedBox(width: 8),
              Text(
                type,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            meal.name,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _voteButton(
                icon: Icons.thumb_up,
                isActive: meal.userVote == 1,
                count: meal.votes > 0 ? meal.votes : null,
                onPressed: () => _handleVote(meal, 1),
              ),
              const SizedBox(width: 8),
              _voteButton(
                icon: Icons.thumb_down,
                isActive: meal.userVote == -1,
                count: meal.votes < 0 ? -meal.votes : null,
                onPressed: () => _handleVote(meal, -1),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _voteButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onPressed,
    int? count,
  }) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: isActive
            ? (icon == Icons.thumb_up ? Colors.green : Colors.red)
            : Colors.grey,
        side: BorderSide(
          color: isActive
              ? (icon == Icons.thumb_up ? Colors.green : Colors.red)
              : Colors.grey,
        ),
      ),
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: count != null ? Text(count.toString()) : const SizedBox.shrink(),
    );
  }

  void _handleVote(Meal meal, int vote) {
    setState(() {
      if (meal.userVote == vote) {
        // Undo vote
        meal.votes -= vote;
        meal.userVote = 0;
      } else {
        // Change vote
        meal.votes += vote - meal.userVote;
        meal.userVote = vote;
      }
    });
  }

  void _showMealSuggestionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Suggest a Meal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Meal Name',
                hintText: 'e.g., Butter Chicken',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField(
              items: ['Breakfast', 'Lunch', 'Dinner']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              decoration: const InputDecoration(labelText: 'Meal Type'),
              onChanged: (_) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Submit logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Meal suggestion submitted!')),
              );
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class DayMeals {
  final String day;
  final Meal breakfast;
  final Meal lunch;
  final Meal dinner;

  DayMeals({
    required this.day,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
  });
}

class Meal {
  final String name;
  int votes;
  int userVote; // -1 = downvote, 0 = no vote, 1 = upvote

  Meal({
    required this.name,
    required this.votes,
    required this.userVote,
  });
}
