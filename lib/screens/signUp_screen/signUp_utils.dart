import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart'; // for kDebugMode

//'
Future<void> signUp({
  required String email,
  required String password,
  required BuildContext context,
}) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Signed up Successfully 🎉')),
    );
    _createAttendance();

    // return userCredential;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.toString()}')),
    );
    debugPrint("error : $e");
  }
}

Future<void> _createAttendance() async {
  final userId = FirebaseAuth.instance.currentUser?.uid;

  if (userId == null) {
    if (kDebugMode) print('[ATT] 🔴 No user signed in');
    return;
  }

  final now = DateTime.now();
  final monthId = DateFormat('yyyy-MM').format(now); // 2025-07
  final dayKey = now.day.toString().padLeft(2, '0'); // 10 → '10'
  final payload = {dayKey: 'present'};

  try {
    await FirebaseFirestore.instance
        .collection('members')
        .doc(userId)
        .collection('attendance')
        .doc(monthId)
        .set(payload, SetOptions(merge: true));
  } catch (e, stack) {
    if (kDebugMode) {
      print('[ATT] ❌ Firestore error: $e');
      print(stack);
    }
    rethrow; // bubble up if you want
  }
}
