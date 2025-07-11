import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/attendence_ui/select_month.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/attendence_ui/scheduleAbsence.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/attendence_ui/confirmAbsence.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/attendence_ui/build_summery_card.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/attendence_ui/show_day_options.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/attendence_utils/fetch_attendence.dart';

class AttendanceDetailsScreen extends StatefulWidget {
  const AttendanceDetailsScreen({super.key});
  @override
  State<AttendanceDetailsScreen> createState() =>
      _AttendanceDetailsScreenState();
}

class _AttendanceDetailsScreenState extends State<AttendanceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);
    final firstDay = DateTime(now.year, now.month, 1);
    final startingWeekday = firstDay.weekday;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Attendance Details'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue.shade500,
        foregroundColor: Colors.white,
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: CustomScrollView(
        slivers: [
          // Summary section
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.grey.shade50,
              child: Row(
                children: [
                  buildSummaryCard(context, 'Present', '18', Colors.green),
                  const SizedBox(width: 16),
                  buildSummaryCard(context, 'Absent', '2', Colors.red),
                  const SizedBox(width: 16),
                  buildSummaryCard(
                      context, 'Days', '$daysInMonth', Colors.lightBlue),
                ],
              ),
            ),
          ),

          // Calendar Header
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('MMMM y').format(now),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.lightBlue.shade800,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today,
                        color: Colors.lightBlue.shade700),
                    onPressed: () => selectMonth(context),
                  ),
                ],
              ),
            ),
          ),

          // Weekday headers
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: GridView.count(
                  crossAxisCount: 7,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.2,
                  children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                      .map(
                        (day) => Center(
                          child: Text(
                            day,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue.shade700,
                            ),
                          ),
                        ),
                      )
                      .toList()),
            ),
          ),

          // Calendar days
          SliverPadding(
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
                          .contains(
                              firstDay.add(Duration(days: dayIndex)).weekday);

                      // Get the status for this day from the attendance map
                      final status = attendance[day];

                      return GestureDetector(
                        onTap: () =>
                            isPast ? null : showDayOptions(context, day),
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: isToday
                                ? Colors.lightBlue.shade50
                                : Colors.transparent,
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
                                  color:
                                      isWeekend ? Colors.grey : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (status != null)
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: status == 'present'
                                        ? Colors.green
                                        : Colors.red,
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
          ),
          _sliverPadding(context)

          // Absence Marking Card
        ],
      ),
    );
  }
}

Widget _sliverPadding(BuildContext context) {
  return SliverPadding(
    padding: const EdgeInsets.all(20),
    sliver: SliverToBoxAdapter(
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_month, color: Colors.lightBlue.shade700),
                  const SizedBox(width: 12),
                  Text(
                    'Mark Absence',
                    style: TextStyle(
                      color: Colors.lightBlue.shade800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Schedule time off or report an absence for today or future dates',
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => scheduleAbsence(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: Colors.lightBlue.shade400),
                      ),
                      child: Text(
                        'Schedule Future Date',
                        style: TextStyle(
                          color: Colors.lightBlue.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => markTodayAbsent(context),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.lightBlue.shade500,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Mark Today',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
