import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

String getMembershipDuration() {
  final creationTime = FirebaseAuth.instance.currentUser?.metadata.creationTime;
  if (creationTime == null) {
    return "New Member";
  }

  final duration = DateTime.now().difference(creationTime);
  log('duration: ${duration.inHours}');
  final years = duration.inDays / 365;

  if (years >= 1) {
    return "${years.toStringAsFixed(1)} Years";
  }

  final months = duration.inDays / 30;
  if (months >= 1) {
    return "${months.round()} Months";
  }

  return "${duration.inDays} Days";
}
