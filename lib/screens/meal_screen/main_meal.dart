import 'package:flutter/material.dart';
import 'dart:ui';

class MealScreen extends StatefulWidget {
  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlassyAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final cardHeight = constraints.maxHeight * 0.32;
          final plateSize = constraints.maxWidth * 0.25;

          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: plateSize * 0.3),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: cardHeight * 0.3,
                  left: constraints.maxWidth * 0.05,
                  right: constraints.maxWidth * 0.05,
                ),
                child: FoodCard(
                  cardHeight: cardHeight,
                  plateSize: plateSize,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final double cardHeight;
  final double plateSize;

  const FoodCard({
    required this.cardHeight,
    required this.plateSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Card container
        Container(
          height: cardHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          padding: EdgeInsets.only(
            left: 16,
            right: plateSize * 0.7,
            top: 16,
            bottom: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title and description
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Caesar Salad (Quinoa)",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Basic Caesar salad with curry olive oil dressing",
                    style: textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),

              // Price and add button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Price: ',
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: "100 Rupees",
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle, color: Colors.blue),
                    onPressed: () {},
                  ),
                ],
              ),

              // Calories
              Container(
                height: cardHeight * 0.15,
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.local_fire_department, color: Colors.orange),
                    SizedBox(width: 8),
                    Text('Calories: 200', style: textTheme.bodyMedium),
                  ],
                ),
              ),

              // Rating
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.amber),
                ),
                child: Column(
                  children: [
                    Text('Rate this meal', style: textTheme.bodySmall),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Icon(
                          index < 4 ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 20,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Plate image
        Positioned(
          top: -plateSize * 0.25,
          right: 0,
          child: Container(
            width: plateSize,
            height: plateSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.lightBlue.shade100,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(plateSize * 0.1),
              child: Image.asset(
                'assets/images/nashtapng.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GlassyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlassyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AppBar(
          backgroundColor: Colors.lightBlueAccent.withOpacity(0.3),
          elevation: 0,
          title: const Text("Meal Selection"),
          centerTitle: true,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
