import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget buildFeedback(String value, String label) {
  return Column(
    children: [
      Text(value,
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.lightBlueAccent[700])),
      SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
    ],
  );
}

Widget buildFeedbackItem(String meal, String comment, double rating) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!)),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(meal, style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 4),
              Text(comment,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700])),
            ],
          ),
        ),
        RatingBarIndicator(
          rating: rating,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 20,
          unratedColor: Colors.grey[300],
        ),
      ],
    ),
  );
}
