import 'package:flutter/material.dart';

Map<String, dynamic> getMealStatus(TimeOfDay now) {
  final meals = ['Breakfast', 'Lunch', 'Dinner'];
  String currentMeal;

  final minutes = now.hour * 60 + now.minute;

  if (minutes >= 420 && minutes < 540) {
    currentMeal = 'Breakfast';
  } else if (minutes >= 960 && minutes < 1020) {
    currentMeal = 'Lunch';
  } else {
    currentMeal = 'Dinner';
  }
  final otherMeals = meals.where((m) => m != currentMeal).toList();

  return {
    'current': currentMeal,
    'others': otherMeals,
  };
}
