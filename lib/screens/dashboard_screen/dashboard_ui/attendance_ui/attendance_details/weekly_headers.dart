import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '';

Widget weeklyHeaders(BuildContext context, AsyncValue isOnline, WidgetRef ref) {
  return SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    sliver: SliverToBoxAdapter(
      child: GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.2,
          children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
              .map(
                (day) => Center(
                  child: Text(
                    day,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue.shade700,
                    ),
                  ),
                ),
              )
              .toList()),
    ),
  );
}
