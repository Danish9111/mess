import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess/extentions.dart';
import 'package:mess/providers/isloading_provider.dart';

class ShowMenuSuggestionSheet extends ConsumerStatefulWidget {
  const ShowMenuSuggestionSheet({super.key});

  @override
  ConsumerState<ShowMenuSuggestionSheet> createState() =>
      _ShowMenuSuggestionSheetState();
}

class _ShowMenuSuggestionSheetState
    extends ConsumerState<ShowMenuSuggestionSheet> {
  // -------- controllers & keys --------
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController menuController = TextEditingController();

  // -------- local state --------
  DateTime? selectedDate;
  String? selectedMealType;

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

  // -------- helpers --------
  InputDecoration _inputDecoration(String label) => InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        errorBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      );

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isLoading = ref.watch(isLoadingProvider);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SizedBox(
        height: screenHeight * 0.5, // 50 % tall
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text('Suggest Menu',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),

              // ---------- Meal Type ----------
              DropdownButtonFormField<String>(
                value: selectedMealType,
                items: const [
                  DropdownMenuItem(
                      value: 'Breakfast', child: Text('Breakfast')),
                  DropdownMenuItem(value: 'Lunch', child: Text('Lunch')),
                  DropdownMenuItem(value: 'Dinner', child: Text('Dinner')),
                ],
                decoration: _inputDecoration('Meal Type'),
                validator: (v) => (v == null || v.isEmpty) ? 'Pick one' : null,
                onChanged: (v) => setState(() => selectedMealType = v),
              ),
              const SizedBox(height: 16),

              // ---------- Menu text ----------
              TextFormField(
                controller: menuController,
                maxLines: 4,
                decoration:
                    _inputDecoration('Enter your menu suggestions here...'),
                validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
              ),
              SizedBox(height: screenHeight * .06),
              // ---------- Submit ----------
              SizedBox(
                width: screenHeight * .4,
                child: isLoading
                    ? const ShowLoading(
                        isLoading: true,
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus(); // close keyboard
                          ref.read(isLoadingProvider.notifier).state = true;
                          if (formKey.currentState!.validate()) {
                            final suggestion = {
                              'date': DateTime.now(),
                              'mealType': selectedMealType,
                              'menu': menuController.text,
                            };
                            await FirebaseFirestore.instance
                                .collection('suggestions')
                                .add(suggestion);
                            // Replace print with your API call etc.
                            debugPrint('Suggestion submitted: $suggestion');

                            ref.read(isLoadingProvider.notifier).state = false;
                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Suggestion submitted successfully!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Submit Suggestion',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
