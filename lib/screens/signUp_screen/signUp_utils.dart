import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

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
    _createAttendence();

    // return userCredential;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.toString()}')),
    );
    debugPrint("error : $e");
  }
}

_createAttendence() {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final formatedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  FirebaseFirestore.instance
      .collection('members')
      .doc(userId)
      .set({formatedDate: 'present'});
}
