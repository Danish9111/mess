import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> scheduleAbsent(DateTime date, BuildContext context) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final monthId = DateFormat('yyyy-MM').format(date); // 2025‑07
  final day = date.day.toString(); // 12
  try {
    await FirebaseFirestore.instance
        .collection('members')
        .doc(uid)
        .collection('attendance')
        .doc(monthId)
        .set({day: 'absent'},
            SetOptions(merge: true)); // merge keeps other days intact
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('successfully updated attendance')));
  } catch (e) {
    debugPrint(e.toString());
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('failed to update attendance')));
  }
}
