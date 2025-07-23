import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:mess/screens/profile_screen/admin_profile/timing_tab/format_time.dart";

Future<void> saveMealTimesToFirestore(BuildContext context,
    Map<String, Map<String, TimeOfDay>> mealTimings) async {
  final firestore = FirebaseFirestore.instance;

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
