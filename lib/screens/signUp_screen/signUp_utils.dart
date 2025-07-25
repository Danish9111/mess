import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart'; // for kDebugMode

//'
Future<void> signUp({
  required String email,
  required String password,
  required BuildContext context,
  required String name,
  required String phone,
}) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signed up Successfully 🎉')),
    );
    await _createAttendance();

    _createMemberInfo({
      'name': name,
      'phone': phone,
    });

    // return userCredential;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.toString()}')),
    );
    debugPrint("error : $e");
  }
}

Future<void> _createMemberInfo(infoPayload) async {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  FirebaseFirestore.instance
      .collection('members')
      .doc(userId)
      .set(infoPayload, SetOptions(merge: true));
}

Future<void> _createAttendance() async {
  final userId = FirebaseAuth.instance.currentUser?.uid;

  if (userId == null) {
    if (kDebugMode) print('🔴 No user signed in');
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
      print('❌ Firestore error: $e');
      print(stack);
    }
    rethrow; // bubble up if you want
  }
}
