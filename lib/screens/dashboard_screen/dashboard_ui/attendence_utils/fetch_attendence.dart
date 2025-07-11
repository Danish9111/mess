import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Future<Map<int, String>> fetchAttendance() async {
  final uid = FirebaseAuth.instance.currentUser!.uid; // real user
  final monthId = DateFormat('yyyy-MM').format(DateTime.now()); // 2025-07

  // 👇 pull ONE document: /members/{uid}/attendance/{yyyy-MM}
  final snap = await FirebaseFirestore.instance
      .collection('members')
      .doc(uid)
      .collection('attendance')
      .doc(monthId)
      .get();

  final data = snap.data() ?? {}; // { "01": "present", ... }

  // convert { "01": ... } → { 1: ... } for easy calendar indexing
  return {
    for (final e in data.entries) int.tryParse(e.key) ?? -1: e.value.toString()
  }..removeWhere((k, _) => k < 1); // kill parse fails
}
