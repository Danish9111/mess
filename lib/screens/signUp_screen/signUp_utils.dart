import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

    // return userCredential;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.toString()}')),
    );
    debugPrint("error : $e");
  }
}
