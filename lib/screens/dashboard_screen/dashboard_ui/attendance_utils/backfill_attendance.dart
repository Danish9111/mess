import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

Future<void> backfillAttendance() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    if (kDebugMode) debugPrint('[ATT] 🔴 No user signed in');
    return;
  }

  // 1️⃣ build month→{day:present} map
  final start = user.metadata.creationTime ?? DateTime.now();
  final end = DateTime.now();
  final months = <String, Map<String, String>>{};
  for (var d = DateTime(start.year, start.month, start.day);
      !d.isAfter(end);
      d = d.add(const Duration(days: 1))) {
    final m = DateFormat('yyyy-MM').format(d);
    months.putIfAbsent(m, () => {})[d.day.toString().padLeft(2, '0')] =
        'present';
  }

  final col = FirebaseFirestore.instance
      .collection('members')
      .doc(user.uid)
      .collection('attendance');
  final batch = FirebaseFirestore.instance.batch();
  int writes = 0;

  // 2️⃣ compare with server, keep only missing days
  for (final entry in months.entries) {
    final monthId = entry.key;
    final payload = entry.value;

    final snap = await col.doc(monthId).get();
    final existing = snap.data() ?? {};

    payload.removeWhere((k, _) => existing.containsKey(k));
    if (payload.isEmpty) continue; // nothing new for this month

    batch.set(col.doc(monthId), payload, SetOptions(merge: true));
    writes += payload.length;
  }

  // 3️⃣ commit if we actually added something
  if (writes == 0) {
    if (kDebugMode) debugPrint(' 🟢 Nothing to back‑fill');
    return;
  }

  try {
    await batch.commit();
    if (kDebugMode) debugPrint('✅ Added $writes missing day(s)');
  } catch (e, st) {
    if (kDebugMode) {
      debugPrint('❌ Firestore error: $e');
      debugPrint(st.toString());
    }
    rethrow;
  }
}
