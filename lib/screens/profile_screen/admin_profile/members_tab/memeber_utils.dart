import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<Map<String, dynamic>> fetchUserInfo() async {
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  final userDoc =
      await FirebaseFirestore.instance.collection('members').doc(userId).get();
  return userDoc.data() ?? {};
}
