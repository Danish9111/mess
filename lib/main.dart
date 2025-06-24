import "package:flutter/material.dart";
import 'main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MessApp());
}

class MessApp extends StatelessWidget {
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
