import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui';
import 'package:mess/extentions.dart';

class GlassyDaysContainer extends ConsumerStatefulWidget {
  const GlassyDaysContainer({super.key});

  @override
  ConsumerState<GlassyDaysContainer> createState() =>
      GlassyDaysContainerState();
}

class GlassyDaysContainerState extends ConsumerState<GlassyDaysContainer> {
  @override
  Widget build(BuildContext context) {
    int selectedDay = DateTime.now().weekday % 7; // Initialize with today
    final List<String> days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];

    return Container(
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(7, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDay = index;
                          });
                        },
                        child: Container(
                          width: dayWidth,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text(
                              days[index],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: selectedDay == index
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
                    left: selectedDay * dayWidth + (dayWidth / 2) - 15,
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
    );
  }
}
