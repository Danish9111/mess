import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess/providers/google_user_provider.dart';

// ''
Future<void> signInWithGoogle(BuildContext context, WidgetRef ref) async {
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
  final user = FirebaseAuth.instance.currentUser;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  try {
    await FirebaseAuth.instance.signInWithCredential(credential);
    debugPrint('signed up successully');
    debugPrint('$user here is other user');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('successfully signed up'),
    ));
  } catch (e) {
    debugPrint('❌error: $e');
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
    return;
  }

  // ✅ Get profile info

  ref.read(userProvider.notifier).setUser(
        name: googleUser.displayName,
        email: googleUser.email,
        photoUrl: FirebaseAuth.instance.currentUser?.photoURL,
      );
}
