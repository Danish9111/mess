import "package:flutter/material.dart";
import 'package:mess/screens/dashboard_screen/dashboard_ui/attendance_ui/show_day_options.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/attendance_utils/fetch_attendance.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget calendarDays(BuildContext context, AsyncValue isOnline, WidgetRef ref) {
  final now = DateTime.now();
  final firstDay = DateTime(now.year, now.month, 1);

  final startingWeekday = firstDay.weekday;
  final daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);

  return SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    sliver: FutureBuilder<Map<int, String>>(
      future: fetchAttendance(),
      builder: (context, snapshot) {
        final attendance = snapshot.data ?? {};
        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index < startingWeekday % 7) {
                return const SizedBox.shrink();
              }
              final dayIndex = index - (startingWeekday % 7);
              if (dayIndex >= daysInMonth) {
                return const SizedBox.shrink();
              }
              final day = dayIndex + 1;
              final isToday = day == now.day;
              final isPast = day < now.day;
              final isWeekend = [DateTime.sunday, DateTime.saturday]
                  .contains(firstDay.add(Duration(days: dayIndex)).weekday);

              // Get the status for this day from the attendance map
              final status = attendance[day];

              return GestureDetector(
                onTap: () => isPast ? null : showDayOptions(context, day),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color:
                        isToday ? Colors.lightBlue.shade50 : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: isToday
                        ? Border.all(
                            color: Colors.lightBlue.shade400,
                            width: 1.5,
                          )
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$day',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isWeekend ? Colors.grey : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (status != null)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                status == 'present' ? Colors.green : Colors.red,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
            childCount: 42,
          ),
        );
      },
    ),
  );
}
