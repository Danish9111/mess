import 'package:flutter/material.dart';

Map<String, dynamic> getMealStatus(TimeOfDay now) {
  final meals = ['Breakfast', 'Lunch', 'Dinner'];
  String currentMeal;

  final minutes = now.hour * 60 + now.minute;

  if (minutes >= 420 && minutes < 540) {
    currentMeal = 'Breakfast';
  } else if (minutes >= 720 && minutes < 1020) {
    currentMeal = 'Lunch';
  } else if (minutes >= 1200 && minutes <= 1440) {
    currentMeal = 'Dinner';
  } else {
    currentMeal = 'Close';
  }

  final otherMeals = meals.where((m) => m != currentMeal).toList();

  return {
    'current': currentMeal,
    'others': otherMeals,
  };
}
