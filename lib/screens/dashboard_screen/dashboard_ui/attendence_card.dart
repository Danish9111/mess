import 'package:flutter/material.dart';

class HorizontalAttendanceBar extends StatelessWidget {
  final Map<String, bool> attendanceMap;

  const HorizontalAttendanceBar({super.key, required this.attendanceMap});

  @override
  Widget build(BuildContext context) {
    final dates = attendanceMap.keys.toList()..sort();

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          final isPresent = attendanceMap[date] ?? false;
          final parsedDate = DateTime.parse(date);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isPresent ? Colors.green[100] : Colors.red[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${parsedDate.day}/${parsedDate.month}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        isPresent ? Icons.check_circle : Icons.cancel,
                        color: isPresent ? Colors.green : Colors.red,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _weekday(parsedDate.weekday),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _weekday(int day) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[day % 7];
  }
}
