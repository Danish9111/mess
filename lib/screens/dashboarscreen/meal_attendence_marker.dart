import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SymmetricalMealGrid extends StatelessWidget {
  final List<Meal> meals = [
    Meal(
        type: 'Breakfast',
        time: TimeOfDay(hour: 8, minute: 0),
        isCurrent: false),
    Meal(
        type: '  Lunch  ',
        time: TimeOfDay(hour: 13, minute: 0),
        isCurrent: true),
    Meal(
        type: ' Dinner      ',
        time: TimeOfDay(hour: 20, minute: 0),
        isCurrent: false),
  ];

  SymmetricalMealGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final currentMeal = meals.firstWhere((meal) => meal.isCurrent);
    final otherMeals = meals.where((meal) => !meal.isCurrent).toList();

    //   return Center(
    //       child: AspectRatio(
    //     aspectRatio: 1,
    //     child: Container(
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(24),
    //       ),
    //       child: LayoutBuilder(
    //         builder: (context, constraints) {
    //           final cardSpacing = constraints.maxWidth * 0.04;
    //           return AspectRatio(
    //               aspectRatio: 1,
    //               child: Container(
    //                   height: 300,
    //                   width: 300,
    //                   child: Row(
    //                     children: [
    //                       Flexible(
    //                         // width: constraints.maxWidth * 2 / 3 - cardSpacing,
    //                         flex: 3,
    //                         child: _buildCurrentMealCard(currentMeal, context),
    //                       ),
    //                       SizedBox(width: cardSpacing),
    //                       Flexible(
    //                         flex: 1,
    //                         child: Column(
    //                           children: [
    //                             Expanded(
    //                               child: Padding(
    //                                 padding:
    //                                     EdgeInsets.only(bottom: cardSpacing / 2),
    //                                 child: _buildSmallMealCard(
    //                                     otherMeals[0], context),
    //                               ),
    //                             ),
    //                             Expanded(
    //                               child: Padding(
    //                                 padding:
    //                                     EdgeInsets.only(top: cardSpacing / 2),
    //                                 child: _buildSmallMealCard(
    //                                     otherMeals[1], context),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ],
    //                   )));
    //         },
    //       ),
    //     ),
    //   ));
    // }

    // Widget _buildCurrentMealCard(Meal meal, context) {
    //   return Container(
    //     decoration: BoxDecoration(
    //       gradient: const LinearGradient(
    //         begin: Alignment.topLeft,
    //         end: Alignment.bottomRight,
    //         colors: [Color(0xFF3A7BD5), Color(0xFF00D2FF)],
    //       ),
    //       borderRadius: BorderRadius.circular(16),
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.blue.withOpacity(0.2),
    //           blurRadius: 12,
    //           spreadRadius: 3,
    //         ),
    //       ],
    //     ),
    //     child: Material(
    //       color: Colors.transparent,
    //       child: InkWell(
    //         borderRadius: BorderRadius.circular(16),
    //         onTap: () => _showMealDetails(meal),
    //         child: Padding(
    //           padding: const EdgeInsets.all(16),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Container(
    //                 width: 80,
    //                 height: 80,
    //                 decoration: BoxDecoration(
    //                   shape: BoxShape.circle,
    //                   color: Colors.white.withOpacity(0.2),
    //                   border: Border.all(
    //                     color: Colors.white.withOpacity(0.3),
    //                     width: 2,
    //                   ),
    //                 ),
    //                 child: const Icon(
    //                   Icons.restaurant,
    //                   size: 40,
    //                   color: Colors.white,
    //                 ),
    //               ),
    //               const SizedBox(height: 16),
    //               Text(
    //                 'NOW SERVING',
    //                 style: TextStyle(
    //                   color: Colors.white.withOpacity(0.9),
    //                   fontSize: 12,
    //                   letterSpacing: 1.5,
    //                 ),
    //               ),
    //               const SizedBox(height: 8),
    //               Text(
    //                 meal.type.toUpperCase(),
    //                 style: const TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 24,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //               const SizedBox(height: 8),
    //               Text(
    //                 meal.time.format(context),
    //                 style: TextStyle(
    //                   color: Colors.white.withOpacity(0.9),
    //                   fontSize: 16,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // }

    // Widget _buildSmallMealCard(Meal meal, context) {
    //   return Container(
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(16),
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.black.withOpacity(0.05),
    //           blurRadius: 8,
    //           spreadRadius: 2,
    //         ),
    //       ],
    //       border: Border.all(
    //         color: Colors.grey.withOpacity(0.1),
    //         width: 1,
    //       ),
    //     ),
    //     child: Material(
    //       color: Colors.transparent,
    //       child: InkWell(
    //         borderRadius: BorderRadius.circular(16),
    //         onTap: () => _showMealDetails(meal),
    //         child: Padding(
    //           padding: const EdgeInsets.all(12),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Container(
    //                 width: 40,
    //                 height: 40,
    //                 decoration: BoxDecoration(
    //                   shape: BoxShape.circle,
    //                   color: Colors.blueGrey.withOpacity(0.1),
    //                 ),
    //                 child: Icon(
    //                   Icons.all_inbox,
    //                   size: 20,
    //                   color: Colors.blueGrey[600],
    //                 ),
    //               ),
    //               const SizedBox(height: 12),
    //               Text(
    //                 meal.type.toUpperCase(),
    //                 style: TextStyle(
    //                   color: Colors.blueGrey[800],
    //                   fontWeight: FontWeight.bold,
    //                   fontSize: 14,
    //                 ),
    //               ),
    //               const SizedBox(height: 4),
    //               Text(
    //                 meal.time.format(context),
    //                 style: TextStyle(
    //                   color: Colors.blueGrey[600],
    //                   fontSize: 12,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    // );

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: screenHeight * 1 / 3.4,
      child: Row(
        spacing: screenWidth * .02,
        children: [
          _buildCurrentCard(),
          Column(
            // spacing: screenHeight * .01,
            children: [
              _buildSmallCard(),
              _buildSmallCard(),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCurrentCard() {
    return Flexible(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.3),
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: Icon(
                      Icons.restaurant,
                      color: Colors.white,
                      size: 40,
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  "Lunch",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    fontFamily: GoogleFonts.lato().fontFamily,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Currently Serving',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(0),
                  child: Flexible(
                    child: Text('Closing in 20 minutes',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  )),
            ]),
      ),
    ));
  }

  Widget _buildSmallCard() {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.grey.shade400,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  "Lunch",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    fontFamily: GoogleFonts.lato().fontFamily,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Currently Serving',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showMealDetails(Meal meal) {
    // Same as previous implementation
  }
}

class Meal {
  final String type;
  final TimeOfDay time;
  final bool isCurrent;

  Meal({
    required this.type,
    required this.time,
    required this.isCurrent,
  });
}
