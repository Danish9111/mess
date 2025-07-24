import 'package:flutter/material.dart';

Widget buildMemberTabBody(
    BuildContext context, double screenHeight, double screenWidth) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    // mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(height: 20),
      const Text(
        "Total Members in Mess",
        style: TextStyle(
          color: Colors.grey,
          fontSize: 20,
        ),
      ),
      const SizedBox(height: 20),
      const Center(child: TotalMembers()),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Active Members Card
          Container(
            height: screenHeight * .15, // Half the original height
            width: screenWidth * .43,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade300,
                  Colors.lightBlueAccent.shade200,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: 4,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Stack(
              children: [
                // Decorative elements (scaled down)
                Positioned(
                  top: -10, // Adjusted position
                  right: -10, // Adjusted position
                  child: Container(
                    height: 60, // Smaller circle
                    width: 60, // Smaller circle
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -15, // Adjusted position
                  left: -15, // Adjusted position
                  child: Container(
                    height: 50, // Smaller circle
                    width: 50, // Smaller circle
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // Content (scaled proportionally)
                Padding(
                  padding: const EdgeInsets.all(16.0), // Reduced padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center vertically
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8), // Reduced padding
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.group,
                          size: 24, // Smaller icon
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 10), // Reduced spacing
                      const Text(
                        'Active Members',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14, // Smaller font
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4), // Reduced spacing
                      const Text(
                        '1,248',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12, // Smaller font
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Inactive Members Card
          Container(
            height: screenHeight * .15, // Half the original height
            width: screenWidth * .43,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: 4,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Stack(
              children: [
                // Decorative elements (scaled down)
                Positioned(
                  top: -10, // Adjusted position
                  right: -10, // Adjusted position
                  child: Container(
                    height: 60, // Smaller circle
                    width: 60, // Smaller circle
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -15, // Adjusted position
                  left: -15, // Adjusted position
                  child: Container(
                    height: 50, // Smaller circle
                    width: 50, // Smaller circle
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.05),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // Content (scaled proportionally)
                Padding(
                  padding: const EdgeInsets.all(16.0), // Reduced padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center vertically
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8), // Reduced padding
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.group_off,
                          size: 24, // Smaller icon
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 10), // Reduced spacing
                      Text(
                        'Inactive Members',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14, // Smaller font
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4), // Reduced spacing
                      Text(
                        '327',
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 12, // Smaller font
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    ],
  );
}

class TotalMembers extends StatelessWidget {
  const TotalMembers({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * .3,
      width: screenWidth * .9,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade300,
            Colors.lightBlueAccent.shade200,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 12,
            spreadRadius: 4,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Stack(
        children: [
          // Decorative elements
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.people_alt_rounded,
                    size: 32,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Total Members',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '42', // Replace with dynamic value
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
                const Spacer(),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'In Mess',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
