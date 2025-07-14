import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess/services.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/attendance_ui/scheduleAbsence.dart';

import 'package:mess/screens/dashboard_screen/dashboard_ui/attendance_utils/schedule_absent_for_weekends.dart';

Widget absenceMarkingCard(BuildContext context, bool isOnline, WidgetRef ref) {
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
                'Schedule off days  for today or future dates',
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  // ── Future date

                  // ── Today
                  Expanded(
                    child: FilledButton(
                      onPressed: () async {
                        // final isOnline =
                        //     ref.read(internetProvider); // grab the latest bool

                        if (isOnline) {
                          scheduleAbsence(context);
                        } else {
                          showInternetSnackBar(context, Colors.redAccent,
                              'No internet connection Check your internet and try again');
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.lightBlue.shade500,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Mark Today',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // ── Weekends (NEW)
                  Expanded(
                    child: FilledButton.icon(
                      icon: const Icon(Icons.weekend, size: 18),
                      label: const Text('Mark Weekends'),
                      onPressed: () async {
                        if (!isOnline) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: SizedBox(
                                    // height: 10,
                                    width: double.infinity,
                                    child: Flexible(
                                      child: Text(
                                          'No internet connection Check your internet and try again'),
                                    )),
                                backgroundColor: Colors.redAccent,
                                // margin: EdgeInsets.only(top: 20),
                              ),
                            );
                          }
                          return; // stop right here if offline
                        }

                        // internet is up—do your thing
                        await scheduleMonthWeekends(DateTime.now(), context);

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                  'All weekends this month marked absent'),
                              backgroundColor: Colors.lightBlue.shade500,
                              // behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.lightBlue.shade700,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => isOnline
                      ? scheduleAbsence(context)
                      : showInternetSnackBar(context, Colors.redAccent,
                          'No internet connection Check your internet and try again'),
                  child: Text('Schedule Future Date',
                      style: TextStyle(
                          color: Colors.lightBlue.shade700,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
