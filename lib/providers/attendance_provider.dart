import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A FutureProvider that fetches the CUMULATIVE total number of meals a user has taken
/// across all months.
///
/// It reads all attendance documents for the current user and counts every
/// instance of a meal marked as 'present'.
final totalMealsProvider = FutureProvider<int>((ref) async {
  try {
    // Get the current user's ID from Firebase Auth.
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      log('[totalMealsProvider] No user is logged in.');
      return 0;
    }

    log('[totalMealsProvider] Fetching all meals for user: $userId');

    final firestore = FirebaseFirestore.instance;
    // Point to the user's entire 'attendance' subcollection.
    final attendanceCollection =
        firestore.collection('members').doc(userId).collection('attendance');

    log('[totalMealsProvider] Querying path: ${attendanceCollection.path}');

    final querySnapshot = await attendanceCollection.get();

    int totalMeals = 0;
    // Iterate over each month's attendance document.
    for (final monthDoc in querySnapshot.docs) {
      final monthData = monthDoc.data();
      // Count the number of 'present' values in the current month's document.
      final mealsThisMonth = monthData.values.where((status) {
        return status.toString().trim().toLowerCase() == 'present';
      }).length;
      log('[totalMealsProvider] Found $mealsThisMonth meals for month ${monthDoc.id}');
      totalMeals += mealsThisMonth;
    }

    log('[totalMealsProvider] Calculated total meals: $totalMeals');
    return totalMeals;
  } catch (e, stackTrace) {
    log('[totalMealsProvider] An error occurred',
        error: e, stackTrace: stackTrace);
    // Return 0 or rethrow to show an error in the UI
    return 0;
  }
});
