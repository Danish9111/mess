import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mess/screens/dashboard_screen/dashboard_ui/attendance_utils/schedule_absent.dart';

void scheduleAbsence(BuildContext context) {
  showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 365)),
    builder: (context, child) => Theme(
      data: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
          primary: Colors.lightBlue.shade500,
        ),
      ),
      child: child!,
    ),
  ).then((selectedDate) {
    if (selectedDate != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Schedule Absence'),
          content: Text(
              'Schedule absence for ${DateFormat.yMMMd().format(selectedDate)}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                await scheduleAbsent(selectedDate, context);

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Scheduled absence for ${DateFormat.yMMMd().format(selectedDate)}'),
                    backgroundColor: Colors.lightBlue.shade500,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.lightBlue.shade500,
              ),
              child:
                  const Text('Schedule', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }
  });
}
