import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<int> countAttendanceThisMonth({required String status}) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return 0;

  final monthId = DateFormat('yyyy-MM').format(DateTime.now());
  final snap = await FirebaseFirestore.instance
      .collection('members')
      .doc(uid)
      .collection('attendance')
      .doc(monthId)
      .get();

  final data = snap.data() ?? {};
  return data.values.where((v) => v == status).length;
}

Future<double> countAttendancePercentage() async {
  final attendanceCount = await countAttendanceThisMonth(status: 'present');

  final now = DateTime.now();
  final daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);
  final attendancePercentage = attendanceCount / daysInMonth * 100;
  return attendancePercentage;
}
