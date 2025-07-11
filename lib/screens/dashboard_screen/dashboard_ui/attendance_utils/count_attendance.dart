import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
