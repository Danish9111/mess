import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Meal model
class Meal {
  final String id;
  final String name;
  final String time;
  final IconData icon;
  bool isAvailable;

  Meal({
    required this.id,
    required this.name,
    required this.time,
    required this.icon,
    this.isAvailable = true,
  });
}

// Meal Provider
final mealsProvider = StateNotifierProvider<MealsNotifier, List<Meal>>((ref) {
  return MealsNotifier();
});

class MealsNotifier extends StateNotifier<List<Meal>> {
  MealsNotifier()
      : super([
          Meal(
            id: '1',
            name: 'Breakfast',
            time: '7:00 - 10:00 AM',
            icon: Icons.breakfast_dining,
          ),
          Meal(
            id: '2',
            name: 'Lunch',
            time: '11:00 AM - 2:00 PM',
            icon: Icons.lunch_dining,
          ),
          Meal(
            id: '3',
            name: 'Dinner',
            time: '5:00 - 9:00 PM',
            icon: Icons.dinner_dining,
          ),
          Meal(
            id: '4',
            name: 'Snacks',
            time: 'All Day',
            icon: Icons.cookie,
          ),
        ]);

  void toggleAvailability(String id) {
    state = [
      for (final meal in state)
        if (meal.id == id)
          Meal(
            id: meal.id,
            name: meal.name,
            time: meal.time,
            icon: meal.icon,
            isAvailable: !meal.isAvailable,
          )
        else
          meal,
    ];
  }
}

// Meal Card Widget
class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;

  const MealCard({
    Key? key,
    required this.meal,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                meal.icon,
                size: 48,
                color: meal.isAvailable ? Colors.lightBlueAccent : Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                meal.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: meal.isAvailable ? null : Colors.grey,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                meal.time,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: meal.isAvailable
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.grey,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Main Screen
class MealScreen extends HookConsumerWidget {
  const MealScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meals = ref.watch(mealsProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive grid columns
    final crossAxisCount = screenWidth < 600
        ? 2
        : screenWidth < 900
            ? 3
            : 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Meals'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: meals.length,
          itemBuilder: (context, index) {
            final meal = meals[index];
            return MealCard(
              meal: meal,
              onTap: () =>
                  ref.read(mealsProvider.notifier).toggleAvailability(meal.id),
            );
          },
        ),
      ),
    );
  }
}
