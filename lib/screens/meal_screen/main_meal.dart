import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:mess/extentions.dart';

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
        // appBar: AppBar(
        //   backgroundColor: Colors.lightBlueAccent.applyOpacity(.9),
        // ),
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
                  foodCard(screenWidth, screenHeight),
                  foodCard(screenWidth, screenHeight),
                  foodCard(screenWidth, screenHeight),
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

Widget foodCard(double screenWidth, double screenHeight) {
  return Container(
    padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
    width: screenWidth * .9,
    height: screenHeight * .3,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 3,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [
        // Food Information Section
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BreakFast',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey[800],
                      ),
                    ),
                    const Text(
                      'Avacardo Toast',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Sourdough bread with mashed avocado, ',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Rs120',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        Icon(Icons.local_fire_department,
                            size: 18, color: Colors.orange[300]),
                        const SizedBox(width: 4),
                        Text(
                          '320 cal',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(
                          5,
                          (index) => Icon(
                                index < 4 ? Icons.star : Icons.star_half,
                                size: 20,
                                color: Colors.amber,
                              )),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '4.6 (128 reviews)',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Image Section
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  height: screenHeight * .03,
                  width: screenWidth * .2,
                  color: Colors.redAccent.shade100,
                  child: const Center(
                      child: Text(
                    'حلال',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16, // optional: increase for better readability
                      fontFamily: 'NotoNastaliqUrdu', // optional: see below
                    ),
                  ))),

              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipOval(
                        child: Container(
                          color: Colors.lightBlueAccent.applyOpacity(.3),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Image(
                          image: AssetImage('assets/images/nashtapng.png')),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: TextButton.icon(
                    icon:
                        Icon(Icons.thumb_up, size: 16, color: Colors.blue[700]),
                    label: Text(
                      'RATE DISH',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: Colors.blue[700],
                      ),
                    ),
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue[50],
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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
  );
}

class GlassyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlassyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            backgroundColor: Colors.lightBlueAccent.withOpacity(0.3),
            elevation: 0,
            title: const Text("Glassy AppBar"),
            centerTitle: true,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}























// Plate image on top of card
      // Positioned(
      //     top: screenHeight * .065,
      //     left: screenWidth * .5,
      //     child: Container(
      //       height: 150,
      //       width: 150,
      //       decoration: const BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: Colors.lightBlueAccent,
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.grey,
      //               spreadRadius: 1,
      //               blurRadius: 10,
      //               offset: Offset(0, 0),
      //             )
      //           ]),
      //       child: Image.asset(
      //         'assets/images/nashtapng.png', // your image here
      //         height: 150,
      //         width: 150,
      //         // fit: BoxFit.cover,
      //       ),
      //     )),