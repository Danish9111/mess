import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import "package:mess/screens/profile_screen/admin_profile/timing_tab/format_time.dart";

Future<void> saveMealTimesToFirestore(BuildContext context) async {
  final firestore = FirebaseFirestore.instance;
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
  try {
    for (var meal in mealTimings.entries) {
      await firestore
          .collection('mealTimings')
          .doc(meal.key.toLowerCase())
          .set({
        'startTime': formatTime(meal.value['start']!),
        'endTime': formatTime(meal.value['end']!),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Meal times saved successfully!'),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("error occured while saving data")));
  }
}
