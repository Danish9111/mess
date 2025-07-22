import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget buildMealActivity() {
  return Container(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Meal Activity",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        _buildMealActivityItem(
            "Last Meal", "Chicken Biryani", "Today", 4.5, Icons.history),
        const Divider(height: 20, thickness: 1),
        _buildMealActivityItem("Favorite Meal", "Paneer Tikka Masala",
            "Ordered 32 times", 4.8, Icons.favorite),
        const Divider(height: 20, thickness: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("This Month", style: TextStyle(fontWeight: FontWeight.w500)),
            Text("12 meals • Rs.2,380",
                style: TextStyle(
                    color: Colors.lightBlueAccent[700],
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const Divider(height: 20, thickness: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.subscriptions, color: Colors.green),
                SizedBox(width: 8),
                Text("Subscription",
                    style: TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(16)),
              child: Text("Active • Renews 15 Oct",
                  style: TextStyle(
                      color: Colors.green[800], fontWeight: FontWeight.bold)),
            )
          ],
        )
      ],
    ),
  );
}

Widget _buildMealActivityItem(
    String title, String meal, String info, double rating, IconData icon) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.lightBlueAccent[50], shape: BoxShape.circle),
        child: Icon(icon, color: Colors.lightBlueAccent),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            const SizedBox(height: 4),
            Text(meal, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(info, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 4),
          RatingBarIndicator(
            rating: rating,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemSize: 16,
            unratedColor: Colors.grey[300],
          ),
        ],
      )
    ],
  );
}
