import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mess/extentions.dart';

class AttendanceDetailsScreen extends StatelessWidget {
  AttendanceDetailsScreen({Key? key}) : super(key: key);

  // This would typically come from your backend
  final Map<int, String> attendanceData = {
    1: 'present',
    3: 'absent',
    5: 'present',
    7: 'absent',
    10: 'present',
    12: 'present',
    15: 'absent',
    18: 'present',
    20: 'present',
    22: 'present',
    25: 'absent',
    28: 'present',
  };

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
                  _buildSummaryCard(context, 'Present', '18', Colors.green),
                  const SizedBox(width: 16),
                  _buildSummaryCard(context, 'Absent', '2', Colors.red),
                  const SizedBox(width: 16),
                  _buildSummaryCard(
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
                    onPressed: () => _selectMonth(context),
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
                    .toList(),
              ),
            ),
          ),

          // Calendar days
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  // Empty days at start of month
                  if (index < startingWeekday % 7) {
                    return const SizedBox.shrink();
                  }

                  final dayIndex = index - (startingWeekday % 7);
                  if (dayIndex >= daysInMonth) {
                    return const SizedBox.shrink();
                  }

                  final day = dayIndex + 1;
                  final isToday = day == now.day;
                  final status = attendanceData[day];
                  final isPast = day < now.day;
                  final isWeekend = [DateTime.sunday, DateTime.saturday]
                      .contains(firstDay.add(Duration(days: dayIndex)).weekday);

                  return GestureDetector(
                    onTap: () => isPast ? _showDayOptions(context, day) : null,
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
                              color: isWeekend ? Colors.grey : Colors.black87,
                            ),
                          ),
                          if (status != null) const SizedBox(height: 4),
                          // if (status != null)
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
                childCount: 42, // Maximum grid items (6 rows x 7 columns)
              ),
            ),
          ),

          // Absence Marking Card
          SliverPadding(
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
                          Icon(Icons.calendar_month,
                              color: Colors.lightBlue.shade700),
                          const SizedBox(width: 12),
                          Text(
                            'Mark Absence',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
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
                              onPressed: () => _scheduleAbsence(context),
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                side: BorderSide(
                                    color: Colors.lightBlue.shade400),
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
                              onPressed: () => _markTodayAbsent(context),
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.lightBlue.shade500,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
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
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
      BuildContext context, String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.applyOpacity(.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDayOptions(BuildContext context, int day) {
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
              '${DateFormat('MMMM d').format(DateTime(DateTime.now().year, DateTime.now().month, day))}',
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
                _confirmAbsence(context, day);
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

  void _confirmAbsence(BuildContext context, int day) {
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Marked $day as absent'),
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
            child: const Text('Confirm', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _markTodayAbsent(BuildContext context) {
    final today = DateTime.now();
    _confirmAbsence(context, today.day);
  }

  void _scheduleAbsence(BuildContext context) {
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
                onPressed: () {
                  // This is where you would update backend
                  // setState(() {
                  //   attendanceData[selectedDate.day] = 'absent';
                  // });
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
                child: const Text('Schedule',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      }
    });
  }

  void _selectMonth(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        int selectedMonth = DateTime.now().month;

        return AlertDialog(
          backgroundColor: Colors.grey.shade200,
          title: Text("Select Month"),
          content: SizedBox(
            width: double.maxFinite,
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              children: List.generate(12, (index) {
                final monthName =
                    DateFormat.MMMM().format(DateTime(0, index + 1));
                return InkWell(
                  onTap: () {
                    Navigator.pop(context, index + 1); // month number
                    // Do whatever with the selected month
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Chip(
                      backgroundColor: Colors.white,
                      label: Text(monthName, textAlign: TextAlign.center),
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
