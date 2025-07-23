import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess/providers/weekly_meal_provider.dart';
import 'dart:developer';

class MealTab extends ConsumerStatefulWidget {
  const MealTab({super.key});

  @override
  _WeeklyMealManagerState createState() => _WeeklyMealManagerState();
}

class _WeeklyMealManagerState extends ConsumerState<MealTab>
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
    // Initialize other days with empty lists
    'monday': {'breakfast': [], 'lunch': [], 'dinner': [], 'snacks': []},
    'tuesday': {'breakfast': [], 'lunch': [], 'dinner': [], 'snacks': []},
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
    try {
      weeklyMeals[day]![mealType]!.add(mealItem);
      final weeklyMealsProvider = ref.watch(weeklyMealProvider.notifier);
      weeklyMealsProvider.state = weeklyMeals;
      debugPrint("weeklyMeals are here:$weeklyMealsProvider.state.toString()");
      log("weeklyMeals are here:$weeklyMealsProvider.state.toString()");
      debugPrint("weeklyMeals: $weeklyMeals");
    } catch (e) {
      log("here is the error: $e");
      debugPrint(e.toString());
    }
  }

  Future<void> saveMealsToFirebase() async {
    await FirebaseFirestore.instance
        .collection('meals')
        .doc('weeklyMeals')
        .set(weeklyMeals);
  }

  void _removeMealItem(String day, String mealType, int index) {
    setState(() {
      weeklyMeals[day]![mealType]!.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: null,
        bottom: TabBar(
          indicatorColor: Colors.lightBlueAccent,
          labelColor: Colors.lightBlueAccent,
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        ...mealTypes.map((mealType) {
          return _buildMealSection(day, mealType);
        }),
        SizedBox(
          width: screenWidth * .7,
          height: screenHeight * .06,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                surfaceTintColor: Colors.lightBlueAccent,
                side: const BorderSide(color: Colors.lightBlueAccent)
                // backgroundColor: Colors.lightBlueAccent,
                ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.save,
                  color: Colors.lightBlueAccent,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Save all',
                  style: TextStyle(color: Colors.lightBlue),
                ),
              ],
            ),
            onPressed: () async {
              try {
                await saveMealsToFirebase();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('successfully saved data')));
              } catch (e) {
                debugPrint(e.toString());
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("error saving data:$e")));
              }
            },
          ),
        )
      ]),
    );
  }

  Widget _buildMealSection(String day, String mealType) {
    final items = weeklyMeals[day]![mealType]!;
    final TextEditingController controller = TextEditingController();

    return Card(
      elevation: 1, // Subtle elevation for depth
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _capitalize(mealType),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600, // Semi-bold
                color: Colors.lightBlueAccent, // Darker text
              ),
            ),
            const SizedBox(height: 12),

            // Meal Items as Chips
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return Chip(
                  label: Text(item),
                  backgroundColor: Colors.lightBlueAccent,
                  labelStyle: const TextStyle(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 0, color: Colors.transparent),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  deleteIcon: const Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.white,
                  ),
                  onDeleted: () => _removeMealItem(day, mealType, index),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                );
              }).toList(),
            ),

            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Add meal item...',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.lightBlueAccent, // Modern accent color
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      if (controller.text.trim().isNotEmpty) {
                        _addMealItem(day, mealType, controller.text.trim());
                        controller.clear();
                      }
                    },
                  ),
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
