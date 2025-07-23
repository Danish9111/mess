import 'package:flutter/material.dart';
import 'package:mess/screens/profile_screen/admin_profile/timing_tab/save_meal_to_firestore.dart';
import 'package:mess/screens/profile_screen/admin_profile/timing_tab/format_time.dart';

//'
class MealTimeSetterScreen extends StatefulWidget {
  const MealTimeSetterScreen({super.key});

  @override
  State<MealTimeSetterScreen> createState() => _MealTimeSetterScreenState();
}

class _MealTimeSetterScreenState extends State<MealTimeSetterScreen> {
  final Map<String, Map<String, TimeOfDay>> mealTimings = {
    'Breakfast': {
      'start': const TimeOfDay(hour: 7, minute: 0),
      'end': const TimeOfDay(hour: 9, minute: 0)
    },
    'Lunch': {
      'start': const TimeOfDay(hour: 12, minute: 0),
      'end': const TimeOfDay(hour: 15, minute: 0)
    },
    'Dinner': {
      'start': const TimeOfDay(hour: 19, minute: 0),
      'end': const TimeOfDay(hour: 0, minute: 0)
    },
  };

  Future<void> pickTime(String meal, String type) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: mealTimings[meal]![type]!,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.lightBlueAccent,
              onPrimary: Colors.white,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        mealTimings[meal]![type] = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('Set Meal Times',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent,
                  )),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: mealTimings.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final meal = mealTimings.keys.elementAt(index);
                return _buildMealCard(meal, isSmallScreen);
              },
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                saveMealTimesToFirestore(context, mealTimings);
              },
              icon: const Icon(Icons.save_rounded),
              label: const Text('SAVE ALL MEAL TIMES'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealCard(String meal, bool isSmallScreen) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.restaurant_menu_rounded,
                    color: Colors.lightBlueAccent),
                const SizedBox(width: 12),
                Text(meal,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
            const SizedBox(height: 20),
            isSmallScreen
                ? Column(
                    children: [
                      _buildTimeButton(meal, 'start'),
                      const SizedBox(height: 12),
                      _buildTimeButton(meal, 'end'),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: _buildTimeButton(meal, 'start')),
                      const SizedBox(width: 16),
                      Expanded(child: _buildTimeButton(meal, 'end')),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeButton(String meal, String type) {
    return OutlinedButton(
      onPressed: () => pickTime(meal, type),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: const BorderSide(color: Colors.lightBlueAccent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            type == 'start' ? Icons.alarm_add_rounded : Icons.alarm_off_rounded,
            color: Colors.lightBlueAccent,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            '${type == 'start' ? 'Start' : 'End'}: ${formatTime(mealTimings[meal]![type]!)}',
            style: const TextStyle(color: Colors.lightBlueAccent, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
