import 'package:flutter_riverpod/flutter_riverpod.dart  ';
import 'package:firebase_auth/firebase_auth.dart';

final uidProvider = Provider<String?>((ref) {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  return uid;
});
