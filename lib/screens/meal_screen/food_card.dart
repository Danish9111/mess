import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess/extentions.dart';
import 'package:mess/screens/meal_screen/show_meal_dialog.dart';

class FoodCard extends ConsumerStatefulWidget {
  final String foodTime;
  final String foodTitle;
  final String foodDescription;
  final int price;
  final int calories;
  final String image;
  final int reviewCount;
  final double ratings;

  const FoodCard(
      {required this.foodTime,
      required this.foodTitle,
      required this.foodDescription,
      required this.price,
      required this.calories,
      required this.image,
      required this.reviewCount,
      required this.ratings,
      super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FoodCardState();
}

class _FoodCardState extends ConsumerState<FoodCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
      width: screenWidth * .9,
      height: screenHeight * .3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.applyOpacity(.2),
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
                        widget.foodTime,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        widget.foodTitle,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.foodDescription,
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
                        widget.price.toString(),
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
                            widget.calories.toString(),
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
                        '${widget.ratings} (${(widget.reviewCount).toString()})',
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
                        fontSize:
                            16, // optional: increase for better readability
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
                        child: Image(image: AssetImage(widget.image)),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: TextButton.icon(
                      icon: Icon(Icons.thumb_up,
                          size: 16, color: Colors.blue[700]),
                      label: Text(
                        'RATE DISH',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: Colors.blue[700],
                        ),
                      ),
                      onPressed: () {
                        showMealRatingDialog(context, 'Avacardo Toast');
                      },
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

  void showMealRatingDialog(BuildContext context, String mealName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MealRatingDialog(mealName: mealName);
      },
    );
  }
}
