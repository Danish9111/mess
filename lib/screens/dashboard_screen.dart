import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40), // 👈 Round only this corner
        )),

        title: Text(''),
        toolbarHeight: screenHeight * .25, // 15% of screen width
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
          child: Stack(
        children: [
          Container(
            color: Colors.lightBlueAccent,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(90), // 👈 Round only this corner
                ),
              ),
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Welcome to the Dashboard!',
                  style: TextStyle(fontSize: 24),
                ),
              )),
        ],
      )),
    );
  }
}
