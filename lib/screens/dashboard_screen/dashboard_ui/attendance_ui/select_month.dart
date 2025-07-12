import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void selectMonth(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      int selectedMonth = DateTime.now().month;

      return AlertDialog(
        backgroundColor: Colors.grey.shade200,
        title: const Text("Select Month"),
        content: SizedBox(
          width: double.maxFinite,
          child: GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            children: List.generate(12, (index) {
              final monthName =
                  DateFormat.MMMM().format(DateTime(0, index + 1));
              return InkWell(
                onTap: () {
                  Navigator.pop(context, index + 1); // month number
                  // Do whatever with the selected month
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    backgroundColor: Colors.white,
                    label: Text(monthName, textAlign: TextAlign.center),
                  ),
                ),
              );
            }),
          ),
        ),
      );
    },
  );
}
