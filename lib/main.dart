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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await backfillAttendance();

  runApp(const ProviderScope(child: MessApp()));
}

class MessApp extends ConsumerWidget {
  const MessApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MessMate',
      home: authState.when(
        data: (user) {
          print("🔥 Firebase User: $user");
          return user == null ? const LoginScreen() : MainScreen();
        },
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        error: (e, _) => Scaffold(
          body: Center(child: Text('Auth Error: $e')),
        ),
      ),
      routes: {
        '/meal': (context) => const MealScreen(),
        '/signUp': (context) => const SignUp(),
        '/dashboard_screen': (context) => const DashboardScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
