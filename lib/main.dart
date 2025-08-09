import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/attendance_utils/backfill_attendance.dart';
import 'package:mess/screens/dashboard_screen/dashboard_ui/dashboard_screen.dart';
import 'package:mess/screens/main_screen.dart';
import 'package:mess/screens/login_screen/login.dart';
import 'package:mess/screens/signUp_screen/signUp.dart';
import 'package:mess/screens/mealScreen.dart';
import 'package:mess/providers/uid_firebase.dart';
import 'package:mess/providers/google_user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:core';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("FCM Token: $fcmToken");

  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    // Note: This callback is fired at each app startup and whenever a new
    // token is generated.
  }).onError((err) {
    debugPrint('Unable to get FCM Token: $err');
  });

  await backfillAttendance();

  runApp(const ProviderScope(child: MessApp()));
}

class MessApp extends ConsumerStatefulWidget {
  const MessApp({super.key});

  @override
  ConsumerState<MessApp> createState() => _MessAppState();
}

class _MessAppState extends ConsumerState<MessApp> {
  @override
  @override
  void initState() {
    super.initState();
    _requestNotificationPermission();
  }

  Future<void> _requestNotificationPermission() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint('🔔 Permission status: ${settings.authorizationStatus}');
  }

  @override
  Widget build(BuildContext context) {
    // ✅ safe zone: inside build
    ref.listen<AsyncValue<User?>>(authStateProvider, (prev, next) {
      next.whenData((u) {
        ref.read(userProvider.notifier).setUser(
              name: u?.displayName,
              email: u?.email,
              photoUrl: u?.photoURL,
            );
      });
    });

    final authState = ref.watch(authStateProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MessMate',
      home: authState.when(
        data: (user) => user == null ? const LoginScreen() : MainScreen(),
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (e, _) => Scaffold(body: Center(child: Text('Auth error: $e'))),
      ),
      routes: {
        '/meal': (_) => const MealScreen(),
        '/signUp': (_) => const SignUp(),
        '/dashboard_screen': (_) => const DashboardScreen(),
        '/login': (_) => const LoginScreen(),
        '/mainScreen': (_) => MainScreen(),
      },
    );
  }
}
