import 'package:flutter/material.dart';

Widget buildProgressSection(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Loyalty Points",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text("340/500",
                style: TextStyle(
                    color: Colors.lightBlueAccent[700],
                    fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)),
            ),
            Container(
              width: 340 / 500 * MediaQuery.of(context).size.width * 0.8,
              height: 20,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.lightBlueAccent, Colors.blueAccent]),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ],
        ),

        // SizedBox(height: 16),
        // Text("Badges Earned",
        //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // _buildBadge("Early Bird", "assets/early_bird.json"),
              // _buildBadge("Zero Waste Hero", "assets/recycle.json"),
              // _buildBadge("Consistent Diner", "assets/medal.json"),
              // _buildBadge("Spice Master", "assets/chili.json"),
            ],
          ),
        )
      ],
    ),
  );
}
