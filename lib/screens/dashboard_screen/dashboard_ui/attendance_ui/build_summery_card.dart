import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
    required this.title,
    required this.color,
    required this.future, // inject the future so we don't recreate it
  });

  final String title;
  final Color color;
  final Future<int> future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: future,
      builder: (context, snap) {
        if (snap.hasError) {
          return Text('Error: ${snap.error}');
        }

        return Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                // // snap.connectionState == ConnectionState.waiting
                //     ? const SizedBox(
                //         height: 22, // same height as the text
                //         width: 22,
                //         child: CircularProgressIndicator(
                //           strokeWidth: 2,
                //           color: Colors.lightBlueAccent,
                //         ),
                //       ):
                Text(
                  '${snap.data ?? 0}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: color,
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
