import 'package:flutter/material.dart';

class MealTab extends StatefulWidget {
  const MealTab({super.key});

  @override
  _WeeklyMealManagerState createState() => _WeeklyMealManagerState();
}

class _WeeklyMealManagerState extends State<MealTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> days = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ];
  final List<String> mealTypes = ['breakfast', 'lunch', 'dinner', 'snacks'];

  Map<String, Map<String, List<String>>> weeklyMeals = {
    'monday': {
      'breakfast': ['Oatmeal', 'Fruit'],
      'lunch': ['Salad', 'Soup'],
      'dinner': ['Grilled Chicken', 'Vegetables'],
      'snacks': ['Yogurt'],
    },
    'tuesday': {
      'breakfast': ['Smoothie'],
      'lunch': ['Sandwich'],
      'dinner': ['Pasta'],
      'snacks': ['Nuts', 'Fruit'],
    },
    // Initialize other days with empty lists
    'wednesday': {'breakfast': [], 'lunch': [], 'dinner': [], 'snacks': []},
    'thursday': {'breakfast': [], 'lunch': [], 'dinner': [], 'snacks': []},
    'friday': {'breakfast': [], 'lunch': [], 'dinner': [], 'snacks': []},
    'saturday': {'breakfast': [], 'lunch': [], 'dinner': [], 'snacks': []},
    'sunday': {'breakfast': [], 'lunch': [], 'dinner': [], 'snacks': []},
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: days.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addMealItem(String day, String mealType, String mealItem) {
    setState(() {
      weeklyMeals[day]![mealType]!.add(mealItem);
    });
  }

  void _removeMealItem(String day, String mealType, int index) {
    setState(() {
      weeklyMeals[day]![mealType]!.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Meal Manager'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: days.map((day) => Tab(text: _capitalize(day))).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: days.map((day) {
          return _buildDayView(day);
        }).toList(),
      ),
    );
  }

  Widget _buildDayView(String day) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: mealTypes.map((mealType) {
          return _buildMealSection(day, mealType);
        }).toList(),
      ),
    );
  }

  Widget _buildMealSection(String day, String mealType) {
    final items = weeklyMeals[day]![mealType]!;
    final TextEditingController controller = TextEditingController();

    return Card(
      col
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _capitalize(mealType),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return ListTile(
                title: Text(item),
                trailing: IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => _removeMealItem(day, mealType, index),
                ),
              );
            }),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Add new meal item',
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (controller.text.trim().isNotEmpty) {
                      _addMealItem(day, mealType, controller.text.trim());
                      controller.clear();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _capitalize(String input) {
    return input[0].toUpperCase() + input.substring(1);
  }
}
