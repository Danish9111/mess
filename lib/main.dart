import "package:flutter/material.dart";
import 'package:mess/screens/signUp_screen/signUp.dart';
import 'screens/main_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart'; // <-- Add this import
import 'package:mess/screens/mealScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mess/screens/login_screen/login.dart ';
// import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // <-- Wrap your app with ProviderScope
  runApp((ProviderScope(child: MessApp())));
}

class MessApp extends StatelessWidget {
  const MessApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLogedIn;
    isLogedIn = true;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MessMate',
        initialRoute: isLogedIn ? '/' : '/login',
        routes: {
          '/': (context) => MainScreen(),
          '/login': (context) => LoginScreen(),
          '/meal': (context) => MealScreen(),
          '/signUp': (context) => SignUp(),
        });
  }
}
