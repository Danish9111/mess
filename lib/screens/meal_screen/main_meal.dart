import 'package:flutter/material.dart';
import 'package:mess/extentions.dart';
import 'package:mess/screens/meal_screen/food_card.dart';
import 'package:carousel_slider/carousel_slider.dart';

// ignore: must_be_immutable'
class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  String? selectedDay;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.lightBlueAccent.applyOpacity(.5),
                Colors.lightBlueAccent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Meals Details',
                style: TextStyle(color: Colors.white)),
            centerTitle: true,
          ),
        ),
      ),
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔹 Day Selector (Chips)

              // 🔹 Carousel
              CarouselSlider(
                items: const [
                  FoodCard(
                    foodTime: 'Breakfast',
                    foodTitle: 'Avacardo Toast',
                    foodDescription: 'Sourdough bread with mashed avocado',
                    price: 120,
                    calories: 320,
                    image: 'assets/images/nashtapng.png',
                    reviewCount: 128,
                    ratings: 4.6,
                  ),
                  FoodCard(
                    foodTime: 'Lunch',
                    foodTitle: 'Avacardo Toast',
                    foodDescription: 'Sourdough bread with mashed avocado',
                    price: 120,
                    calories: 320,
                    image: 'assets/images/nashtapng.png',
                    reviewCount: 128,
                    ratings: 4.6,
                  ),
                  FoodCard(
                    foodTime: 'Dinner',
                    foodTitle: 'Avacardo Toast',
                    foodDescription: 'Sourdough bread with mashed avocado',
                    price: 120,
                    calories: 320,
                    image: 'assets/images/nashtapng.png',
                    reviewCount: 128,
                    ratings: 4.6,
                  ),
                ],
                options: CarouselOptions(
                  height: 300,
                  autoPlay: false,
                  enlargeCenterPage: true,
                ),
              ),

              const SizedBox(height: 20),
              Wrap(
                children: [
                  'Sunday',
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday'
                ].map((day) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ChoiceChip(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.transparent),
                      label: Text(day),
                      selected: selectedDay == day,
                      selectedColor: Colors.lightBlueAccent.applyOpacity(.9),
                      onSelected: (_) {
                        setState(() {
                          selectedDay = day;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              caloriCounter(screenHeight, screenWidth),
            ],
          ),
        ),
      ),
    );
  }
}

Widget caloriCounter(double screenHeight, double screenWidth) {
  return Container(
    alignment: Alignment.center,
    child: Container(
        height: screenHeight * .1,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
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
              '  2000 calories Today',
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )),
  );
}
