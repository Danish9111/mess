import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mess/providers/total_meals_provider.dart';
import 'package:mess/providers/google_user_provider.dart';
import 'package:mess/screens/profile_screen/user_profile/profileHeader/profileHeader_utils.dart';

Widget buildProfileHeader(BuildContext context, WidgetRef ref) {
  final googleUser = ref.watch(userProvider);
  final totalMealsAsync = ref.watch(totalMealsProvider);
  final url = googleUser?.photoUrl;

  final totalMealsText = totalMealsAsync.when(
    data: (count) => '$count Meals',
    loading: () => '...',
    error: (e, s) => 'Error',
  );

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(color: Colors.lightBlueAccent),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.lightBlueAccent[100],
          child: ClipOval(
            child: url != null && url.isNotEmpty
                ? Image.network(
                    url,
                    fit: BoxFit.cover,
                    width: 80.0, // 2 * radius
                    height: 80.0,
                    errorBuilder: (context, error, stackTrace) {
                      // This widget is shown if the image fails to load.
                      return const Icon(Icons.person,
                          size: 40, color: Colors.white);
                    },
                  )
                : const Icon(Icons.person, size: 40, color: Colors.white),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                googleUser?.name ?? "Guest User",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber),
                ),
                child: Text("Gold Member",
                    style: TextStyle(
                        color: Colors.amber[800], fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildStatItem(Icons.calendar_today,
                      DateFormat('MMM yyyy').format(DateTime.now())),
                  _buildStatItem(Icons.restaurant, totalMealsText),
                  _buildStatItem(Icons.timelapse, getMembershipDuration()),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget _buildStatItem(IconData icon, String text) {
  return Expanded(
    child: Row(
      children: [
        Icon(icon, size: 14, color: Colors.white),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12, color: Colors.white))
      ],
    ),
  );
}
