import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mess/services.dart';

void confirmAbsence(BuildContext context, int day) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirm Absence'),
      content: Text(
          'Mark ${DateFormat('MMMM d').format(DateTime(DateTime.now().year, DateTime.now().month, day))} as absent?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            // This is where you would update backend
            // setState(() {
            //   attendanceData[day] = 'absent';
            // });
            Navigator.pop(context);
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(),
            //     backgroundColor: Colors.lightBlue.shade500,
            //     behavior: SnackBarBehavior.floating,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //   ),
            // );
            showInternetSnackBar(
                context, Colors.lightBlueAccent, 'Marked $day as absent');
          },
          style: FilledButton.styleFrom(
            backgroundColor: Colors.lightBlue.shade500,
          ),
          child: const Text('Confirm', style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}

void markTodayAbsent(BuildContext context) {
  final today = DateTime.now();
  confirmAbsence(context, today.day);
}
