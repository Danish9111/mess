import 'package:flutter/material.dart';
import 'dart:ui';

class MealScreen extends StatefulWidget {
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
        // appBar: AppBar(
        //   backgroundColor: Colors.lightBlueAccent.withOpacity(.9),
        // ),
        appBar: GlassyAppBar(),
        body: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              caloriCounter(screenWidth, screenHeight),
              foodCard(screenWidth, screenHeight),
              foodCard(screenWidth, screenHeight),
              foodCard(screenWidth, screenHeight),
            ],
          ),
        ));
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
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.whatshot,
              size: 40,
              color: Colors.white,
            ),
            Text(
              '  2000 Calories',
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

Widget foodCard(double screenWidth, double screenHeight) {
  return Stack(
    clipBehavior: Clip.none, // allow overflow!
    children: [
      // Card below
      Container(
        width: screenWidth * .7,
        height: screenHeight * .3,
        padding: const EdgeInsets.all(16),
        // margin: const EdgeInsets.only(bottom: 60), // give space for plate image
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
          boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black12)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FractionallySizedBox(
              widthFactor: .6,
              child: Column(
                children: [
                  // reserve space for image overlap
                  const Text("Caesar Salad (Quinoa)",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text("Basic Caesar salad with curry olive"),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Price:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
                        width: 4), // Add space between price and value
                    const Text("100 Rupees")
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: screenHeight * .05,
              width: screenWidth * .4,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: [Icon(Icons.whatshot), Text('Calories : 200')],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.all(8),
              width: screenWidth * .4,
              height: screenHeight * .09,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    width: 1,
                    color: Colors.amber,
                  )),
              child: Column(
                children: [
                  Text('Give this Meal a rating '),
                  SizedBox(
                    height: screenWidth * .01,
                  ),
                  Row(children: [
                    ...List.generate(
                      4,
                      (index) => Icon(
                        Icons.star_border,
                        color: Colors.amber,
                      ),
                    ),
                    Text('(4.5)')
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
      // Plate image on top of card
      Positioned(
          top: screenHeight * .065,
          left: screenWidth * .5,
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.lightBlueAccent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, 0),
                  )
                ]),
            child: Image.asset(
              'assets/images/nashtapng.png', // your image here
              height: 150,
              width: 150,
              // fit: BoxFit.cover,
            ),
          )),
    ],
  );
}

class GlassyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlassyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      // ⛔ keeps blur inside bounds
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AppBar(
          backgroundColor: Colors.lightBlueAccent.withOpacity(0.3),
          elevation: 0,
          title: const Text("Glassy AppBar"),
          centerTitle: true,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
