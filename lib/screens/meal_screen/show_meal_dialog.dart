import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MealRatingDialog extends StatefulWidget {
  final String mealName;

  const MealRatingDialog({super.key, required this.mealName});

  @override
  __MealRatingDialogState createState() => __MealRatingDialogState();
}

class __MealRatingDialogState extends State<MealRatingDialog> {
  int _selectedRating = 0;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        'Rate ${widget.mealName}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('How was your meal?', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 15),
          // Star rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _selectedRating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 36,
                ),
                onPressed: () {
                  setState(() {
                    _selectedRating = index + 1;
                  });
                },
              );
            }),
          ),
          const SizedBox(height: 15),
          // Comment field
          TextField(
            controller: _commentController,
            decoration: InputDecoration(
              hintText: 'Add comments (optional)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.all(12),
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('CANCEL', style: TextStyle(color: Colors.grey)),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          onPressed: () async {
            if (_selectedRating > 0) {
              final ratingData = {
                'meal': widget.mealName,
                'rating': _selectedRating,
                'comment': _commentController.text.trim(),
                'timestamp': DateTime.now(),
                'userId': uid,
              };

              try {
                await FirebaseFirestore.instance
                    .collection('ratings')
                    .add(ratingData);

                if (context.mounted) {
                  Navigator.pop(context);
                  _showConfirmation(context);
                }
              } catch (e) {
                debugPrint('Rating submission error: $e');
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error submitting rating: $e'),
                    ),
                  );
                }
              }
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select a rating'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            }
          },
          child: const Text('SUBMIT'),
        ),
      ],
    );
  }

  void _showConfirmation(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Thanks for rating ${widget.mealName}!'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
