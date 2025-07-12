import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> signInWithGoogle(BuildContext context) async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  try {
    // final user = await GoogleSignIn().signIn();
    if (googleUser == null) {
      debugPrint('user is null');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign up cancelled by user')));

      return;
    } // 👈 user hit back or cancel
  } catch (e) {
    debugPrint('❌error: $e');
  }

  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  try {
    await FirebaseAuth.instance.signInWithCredential(credential);
  } catch (e) {
    debugPrint('❌error: $e');
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
    return;
  }

  // ✅ Get profile info
  final displayName = googleUser.displayName;
  final email = googleUser.email;
  final photoUrl = googleUser.photoUrl;

  debugPrint("Name: $displayName");
  debugPrint("Email: $email");
  debugPrint("Profile Image URL: $photoUrl");
}
