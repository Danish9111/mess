import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'dashboard_body.dart'; // Assuming you have a separate file for the body content
import 'package:mess/extentions.dart'; // Importing the extension for color opacity
import 'package:firebase_auth/firebase_auth.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedDay = DateTime.now().weekday % 7; // Initialize with today
  final List<String> days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
          ),
        ),
        flexibleSpace: Stack(
          children: [
            // Gradient background
            Container(
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                ),
              ),
            ),

            // Content layout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  // Profile section + actions
                  SizedBox(height: MediaQuery.of(context).padding.top + 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile with avatar and text
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: Colors.white.applyOpacity(0.3),
                            child: const Icon(Icons.person,
                                size: 30, color: Colors.white),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nadeem Danish',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.lato().fontFamily,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Favourite Meal : Chicken Biryani 😍',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.applyOpacity(0.9),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const Spacer(),

                      // Vertical action buttons
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.applyOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.notifications_active,
                                  color: Colors.white, size: 26),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.settings,
                                  color: Colors.white, size: 26),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          title: Text('Confirm Logout'),
                                          content:
                                              Text('Are you sure to Logout?'),
                                          actions: [
                                            TextButton(
                                              child: Text('cancel'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                            TextButton(
                                              child: Text('logout'),
                                              onPressed: () {
                                                bool result = confirmLogout();

                                                if (result == true) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content:
                                                              Text('success')));
                                                }
                                                Navigator.pop(context);
                                              },
                                            )
                                          ]);
                                    });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  // Enhanced glassy days bar with click functionality
                  Container(
                    height: 70,
                    margin: const EdgeInsets.only(bottom: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.applyOpacity(0.25),
                          Colors.white.applyOpacity(0.15),
                        ],
                      ),
                      border: Border.all(
                        color: Colors.white.applyOpacity(0.1),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.applyOpacity(0.2),
                          blurRadius: 30,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final containerWidth = constraints.maxWidth;
                            final dayWidth = containerWidth / 7;
                            return Stack(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: List.generate(7, (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedDay = index;
                                        });
                                      },
                                      child: Container(
                                        width: dayWidth,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Center(
                                          child: Text(
                                            days[index],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: _selectedDay == index
                                                  ? FontWeight.bold
                                                  : FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                // Animated indicator
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  left: _selectedDay * dayWidth +
                                      (dayWidth / 2) -
                                      15,
                                  bottom: 10,
                                  child: Container(
                                    width: 30,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        title: const Text(''),
        toolbarHeight: MediaQuery.of(context).size.height * 0.3,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // body: const DashboardBody(),
      body: Center(
        child: Stack(
          children: [
            Container(
              color: Colors.lightBlueAccent,
              height: double.infinity,
              width: double.infinity,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(90),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(90),
                  ),
                ),
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: DashboardBody(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

confirmLogout() {
  try {
    FirebaseAuth.instance.signOut();
    return true;
  } catch (e) {
    return e;
  }
}
