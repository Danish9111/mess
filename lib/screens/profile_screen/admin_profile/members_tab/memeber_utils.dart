import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String? userId = FirebaseAuth.instance.currentUser?.uid;

Future<Map<String, dynamic>> fetchUserInfo() async {
  final userDoc =
      await FirebaseFirestore.instance.collection('members').doc(userId).get();
  return userDoc.data() ?? {};
}

Future<void> deleteMember() async {
  try {
    await FirebaseFirestore.instance.collection('members').doc(userId).delete();
  } catch (e) {
    print('Error deleting member: $e');
  }
}
