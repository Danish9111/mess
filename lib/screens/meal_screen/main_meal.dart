import 'package:flutter/material.dart';
import 'package:mess/extentions.dart';
import 'package:mess/screens/meal_screen/food_card.dart';

// ignore: must_be_immutable'
class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          toolbarHeight: screenHeight * .150,
          backgroundColor: Colors.lightBlueAccent.applyOpacity(.9),
          title: caloriCounter(screenWidth, screenHeight),
        ),
        body: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 20,
                children: [
                  const FoodCard(
                    foodTime: 'Lunch',
                    foodTitle: 'Avacardo Toast',
                    foodDescription: 'Sourdough bread with mashed avocado',
                    price: 120,
                    calories: 320,
                    image: 'assets/images/nashtapng.png',
                    reviewCount: 128,
                    ratings: 4.6,
                  ),
                  // FoodCard(),
                  // FoodCard(),
                  SizedBox(
                    height: screenHeight * .02,
                  )
                ],
              ),
            )));
  }
}

Widget caloriCounter(double screenHeight, double screenWidth) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(top: screenHeight * .05),
    child: Container(
        height: screenHeight * .18,
        width: screenWidth * .40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.whatshot,
              size: 40,
              color: Colors.amberAccent,
            ),
            Text(
              '  2000 Calories Today',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )),
  );
}
