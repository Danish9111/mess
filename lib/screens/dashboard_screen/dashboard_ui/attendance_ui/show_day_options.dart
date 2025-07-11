import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/attendance_ui/confirmAbsence.dart';

void showDayOptions(BuildContext context, int day) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            DateFormat('MMMM d').format(
                DateTime(DateTime.now().year, DateTime.now().month, day)),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.lightBlue.shade800,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: Icon(Icons.edit, color: Colors.lightBlue.shade700),
            title: const Text('Mark as Absent'),
            onTap: () {
              Navigator.pop(context);
              confirmAbsence(context, day);
            },
          ),
          ListTile(
            leading: Icon(Icons.info, color: Colors.lightBlue.shade700),
            title: const Text('View Details'),
            onTap: () {
              Navigator.pop(context);
              // Show day details
            },
          ),
        ],
      ),
    ),
  );
}
