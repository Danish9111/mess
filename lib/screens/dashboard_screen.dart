import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class DashboardScreen extends StatelessWidget {
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
                            backgroundColor: Colors.white.withOpacity(0.3),
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
                                  color: Colors.white.withOpacity(0.9),
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
                          color: Colors.white.withOpacity(0.15),
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
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  // Enhanced glassy days bar
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      height: 70,
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.25),
                            Colors.white.withOpacity(0.15),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 30,
                            spreadRadius: 2,
                            // offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(7, (index) {
                              final days = [
                                'SUN',
                                'MON',
                                'TUE',
                                'WED',
                                'THU',
                                'FRI',
                                'SAT'
                              ];
                              final isToday =
                                  index == DateTime.now().weekday % 7;

                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                                decoration: BoxDecoration(
                                  color: isToday
                                      ? Colors.white.withOpacity(0.3)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      days[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: isToday
                                            ? FontWeight.bold
                                            : FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    if (isToday) const SizedBox(height: 4),
                                    if (isToday)
                                      Container(
                                        height: 4,
                                        width: 4,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                      )
                                  ],
                                ),
                              );
                            }),
                          ),
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
                  topRight: Radius.circular(90),
                  // 👈 Round only this corner
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
