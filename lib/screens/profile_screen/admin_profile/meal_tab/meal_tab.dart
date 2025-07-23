import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess/providers/weekly_meal_provider.dart';

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
    final notifier = ref.read(weeklyMealProvider.notifier);
    // Create a deep copy of the current state to ensure immutability
    final currentState = notifier.state;
    final newState = Map<String, Map<String, List<String>>>.from(currentState)
        .map((dayKey, mealMap) {
      return MapEntry(
          dayKey,
          Map<String, List<String>>.from(mealMap).map(
            (mealTypeKey, mealList) =>
                MapEntry(mealTypeKey, List<String>.from(mealList)),
          ));
    });

    // Add the new item
    newState[day]?[mealType]?.add(mealItem);

    // Update the provider's state
    notifier.state = newState;
  }

  Future<void> saveMealsToFirebase() async {
    final mealsToSave = ref.read(weeklyMealProvider);
    await FirebaseFirestore.instance
        .collection('meals')
        .doc('weeklyMeals')
        .set(mealsToSave);
  }

  void _removeMealItem(String day, String mealType, int index) {
    final notifier = ref.read(weeklyMealProvider.notifier);
    final currentState = notifier.state;
    final newState =
        Map<String, Map<String, List<String>>>.from(currentState).map(
      (key, value) => MapEntry(
          key,
          Map<String, List<String>>.from(value).map(
            (innerKey, innerValue) =>
                MapEntry(innerKey, List<String>.from(innerValue)),
          )),
    );
    newState[day]?[mealType]?.removeAt(index);
    notifier.state = newState;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
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
        ));
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
        ]));
  }

  Widget _buildMealSection(String day, String mealType) {
    final weeklyMeals = ref.watch(weeklyMealProvider);
    final items = weeklyMeals[day]?[mealType] ?? [];
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
