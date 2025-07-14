import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:mess/providers/connectivity_provider.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/attendance_ui/attendance_details/absence_marking_card.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/attendance_ui/attendance_details/calendar_days.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/attendance_ui/select_month.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/attendance_ui/build_summery_card.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/attendance_utils/count_attendance.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/attendance_ui/attendance_details/weekly_headers.dart';

class AttendanceDetailsScreen extends ConsumerStatefulWidget {
  const AttendanceDetailsScreen({super.key});
  @override
  ConsumerState<AttendanceDetailsScreen> createState() =>
      _AttendanceDetailsScreenState();
}

class _AttendanceDetailsScreenState
    extends ConsumerState<AttendanceDetailsScreen> {
  final checker = InternetConnectionChecker.createInstance(
    addresses: [
      AddressCheckOption(
        uri: Uri.parse('https://clients3.google.com/generate_204'),
        timeout: const Duration(milliseconds: 100),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final isOnline = ref.watch(internetProvider);
    final theme = Theme.of(context);
    final now = DateTime.now();

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
                  SummaryCard(
                      title: 'Present',
                      color: Colors.green,
                      future: countAttendanceThisMonth(status: 'present')),
                  const SizedBox(
                    width: 10,
                  ),
                  SummaryCard(
                      title: 'Absent',
                      color: Colors.red,
                      future: countAttendanceThisMonth(status: 'absent')),
                  const SizedBox(
                    width: 10,
                  ),
                  SummaryCard(
                      title: 'Days',
                      color: Colors.lightBlueAccent,
                      future: countAttendanceThisMonth(status: 'days')),
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

          // Weekday headers :check respective files
          weeklyHeaders(context, isOnline, ref),
          // Calendar days

          calendarDays(context, isOnline, ref),
          // Absence Marking Card

          absenceMarkingCard(context,
              isOnline.value == InternetConnectionStatus.connected, ref)
        ],
      ),
    );
  }
}
