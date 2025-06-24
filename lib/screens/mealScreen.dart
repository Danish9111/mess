import 'package:flutter/material.dart';

class MealScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Screen'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Meal Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
