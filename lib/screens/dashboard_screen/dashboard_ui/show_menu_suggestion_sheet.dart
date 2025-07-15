import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowMenuSuggestionSheet extends ConsumerStatefulWidget {
  const ShowMenuSuggestionSheet({super.key});

  @override
  ConsumerState<ShowMenuSuggestionSheet> createState() =>
      showMenuSuggestionSheetState();
}

class showMenuSuggestionSheetState
    extends ConsumerState<ShowMenuSuggestionSheet> {
  @override
  build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return StatefulBuilder(
      builder: (context, setState) {
        // Form state variables
        DateTime? selectedDate;
        String? selectedMealType;
        final menuController = TextEditingController();

        // Date picker function
        Future<void> pickDate() async {
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)),
          );
          if (pickedDate != null) {
            setState(() => selectedDate = pickedDate);
          }
        }

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SizedBox(
            height: screenHeight * 0.65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Suggest Menu',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Date Selection
                GestureDetector(
                  onTap: pickDate,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            size: 20, color: Colors.blue),
                        const SizedBox(width: 10),
                        Text(
                          selectedDate == null
                              ? "Select date"
                              : DateFormat('MMM dd, yyyy')
                                  .format(selectedDate!),
                          style: TextStyle(
                            color: selectedDate == null
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Meal Type Selection
                DropdownButtonFormField<String>(
                  value: selectedMealType,
                  decoration: InputDecoration(
                    labelText: 'Meal Type',
                    focusColor: Colors.lightBlueAccent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: 'Breakfast', child: Text('Breakfast')),
                    DropdownMenuItem(value: 'Lunch', child: Text('Lunch')),
                    DropdownMenuItem(value: 'Dinner', child: Text('Dinner')),
                  ],
                  onChanged: (value) =>
                      setState(() => selectedMealType = value),
                ),
                const SizedBox(height: 16),

                // Menu Input
                const Text(
                  'Menu Suggestions',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: menuController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Enter your menu suggestions here...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      // Validation and submission logic
                      if (selectedDate == null ||
                          selectedMealType == null ||
                          menuController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all fields'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      // Submit logic would go here (API call, etc.)
                      final suggestion = {
                        'date': DateFormat('yyyy-MM-dd').format(selectedDate!),
                        'mealType': selectedMealType,
                        'menu': menuController.text,
                      };

                      print('Suggestion submitted: $suggestion');
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Suggestion submitted successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    child: const Text(
                      'Submit Suggestion',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
