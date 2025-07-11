import 'package:flutter/material.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/attendance_utils/schedule_absent.dart';

//'
Future<void> scheduleMonthWeekends(DateTime today, BuildContext context) async {
  final first = DateTime(today.year, today.month, 1);
  final next = DateTime(today.year, today.month + 1, 1);
  try {
    for (var d = first; d.isBefore(next); d = d.add(const Duration(days: 1))) {
      if (d.weekday == DateTime.saturday || d.weekday == DateTime.sunday) {
        await scheduleAbsent(d, context); // your existing writer
        debugPrint('success');
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}
