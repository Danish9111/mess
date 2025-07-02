import "package:flutter/material.dart";
import 'screens/main_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart'; // <-- Add this import

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // <-- Wrap your app with ProviderScope
  runApp((ProviderScope(child: MessApp())));
}

class MessApp extends StatelessWidget {
  const MessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MessMate',
        initialRoute: '/',
        routes: {
          '/': (context) => MainScreen(),
          // '/login':(context) => LoginScreen(),
          // '/meal' : (context) => MealScreen(),
        });
  }
}
