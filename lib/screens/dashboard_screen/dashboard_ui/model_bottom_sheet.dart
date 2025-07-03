import 'package:flutter/material.dart';
import 'package:mess/extentions.dart';

Widget buildModelBottomSheet(context, String randomMeal, String timing) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  return Container(
    height: screenHeight * .9,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    child: SingleChildScrollView(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Meal Details',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
          spacing: screenHeight * .01,
          children: [
            BuildMealDetailRow(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                meal: 'Roti + anda',
                mealpath: 'assets/images/nashtapng.png'),
            BuildMealDetailRow(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                meal: 'chaay',
                mealpath: 'assets/images/tea.png'),
          ],
        ),
        Row()
      ],
    )),
  );
}

class BuildMealDetailRow extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final String mealpath;
  final String meal;

  const BuildMealDetailRow(
      {super.key,
      required this.screenWidth,
      required this.screenHeight,
      required this.meal,
      required this.mealpath});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: screenWidth * .04,
      children: [
        Container(
          height: screenHeight * .15,
          width: screenWidth * .5,
          decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20))),

          //   // alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            heightFactor: .5,
            widthFactor: .5,
            child: CircleAvatar(
              backgroundColor: Colors.white.applyOpacity(.4),
              child: Image.asset(mealpath),
            ),
          ),
        ),
        Container(
          width: screenWidth * .4,
          height: screenHeight * .15,
          padding: EdgeInsets.all(screenWidth * .05),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meal, // Meal title
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.schedule, size: 16, color: Colors.grey.shade600),
                  SizedBox(width: 6),
                  Text(
                    "8:00 AM",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              Text(
                "Roti + Egg, served warm",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
      ],
    );
  }
}
