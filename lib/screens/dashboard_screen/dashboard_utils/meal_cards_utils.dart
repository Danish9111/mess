import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class MealTiming {
  String mealTiming() {
    return DateFormat.jm().format(DateTime.now());
  }
}

class MealCountdown extends StatefulWidget {
  const MealCountdown({super.key});

  @override
  _MealCountdownState createState() => _MealCountdownState();
}

class _MealCountdownState extends State<MealCountdown> {
  late Timer _timer;
  Duration _remaining = Duration.zero;
  String _statusText = "Loading...";
  // String _currentMeal = "";

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  DateTime convertToDateTime(TimeOfDay tod) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  }

  void _startTimer() {
    _updateStatus();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateStatus();
    });
  }

  void _updateStatus() {
    final now = DateTime.now();

    // Correct meal times
    final startBreakfast = convertToDateTime(TimeOfDay(hour: 7, minute: 0));
    final endBreakfast = convertToDateTime(TimeOfDay(hour: 8, minute: 59));

    final startLunch = convertToDateTime(TimeOfDay(hour: 12, minute: 0));
    final endLunch = convertToDateTime(TimeOfDay(hour: 17, minute: 59));

    final startDinner = convertToDateTime(TimeOfDay(hour: 20, minute: 0));
    final endDinner = convertToDateTime(TimeOfDay(hour: 24, minute: 0));

    String status = "";
    String meal = "";
    Duration remaining = Duration.zero;

    if (now.isAfter(startBreakfast) && now.isBefore(endBreakfast)) {
      meal = "Breakfast";
      remaining = endBreakfast.difference(now);
      status = "Closing in ${_formatDuration(remaining)}";
    } else if (now.isBefore(startBreakfast)) {
      meal = "Breakfast";
      status = "Preparing for $meal";
    } else if (now.isAfter(startLunch) && now.isBefore(endLunch)) {
      meal = "Lunch";
      remaining = endLunch.difference(now);
      status = "Closing in ${_formatDuration(remaining)}";
    } else if (now.isBefore(startLunch)) {
      meal = "Lunch";
      status = "Preparing for $meal";
    } else if (now.isAfter(startDinner) && now.isBefore(endDinner)) {
      meal = " Dinner ";
      remaining = endDinner.difference(now);
      status = "Closing in ${_formatDuration(remaining)}";
    } else if (now.isBefore(startDinner)) {
      meal = "Dinner";
      status = "Preparing for $meal";
    } else {
      status = "All meals closed";
    }

    setState(() {
      _statusText = status;
      _remaining = remaining;
      // _currentMeal = meal;
    });
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _statusText,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: _statusText.contains("Closing")
            ? Colors.orange
            : _statusText.contains("Preparing")
                ? Colors.blue
                : Colors.red,
      ),
    );
  }
}
