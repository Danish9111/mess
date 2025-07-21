import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          title: const Text('Admin Profile'),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.lightBlueAccent,
            indicatorWeight: 3,
            labelColor: Colors.lightBlueAccent,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontSize: 15),
            tabs: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('meal'),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('Timing'),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('expense'),
              )
            ],
          ),
        ),
        body: const TabBarView(children: [
          Center(child: Text('meal')),
          MealTimeSetterScreen(),
          Center(child: Text('expense'))
        ]),
      ),
    );
  }
}

// class TimePicker24Hour extends StatefulWidget {
//   const TimePicker24Hour({super.key});

//   @override
//   State<TimePicker24Hour> createState() => _TimePicker24HourState();
// }

// class _TimePicker24HourState extends State<TimePicker24Hour> {
//   TimeOfDay? selectedTime;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 40),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12)),
//               ),
//               child: Text(
//                 selectedTime != null
//                     ? '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}'
//                     : 'Pick Time',
//               ),
//               onPressed: () async {
//                 final TimeOfDay? time = await showTimePicker(
//                   context: context,
//                   initialTime: TimeOfDay.now(),
//                   builder: (context, child) {
//                     return MediaQuery(
//                       data: MediaQuery.of(context)
//                           .copyWith(alwaysUse24HourFormat: false),
//                       child: Theme(
//                         data: ThemeData.light().copyWith(
//                           colorScheme: const ColorScheme.light(
//                             primary: Colors.blueAccent,
//                             onPrimary: Colors.white,
//                             surface: Colors.white,
//                             onSurface: Colors.black87,
//                           ),
//                           dialogBackgroundColor: Colors.white,
//                           timePickerTheme: const TimePickerThemeData(
//                             dayPeriodColor: Colors.lightBlueAccent,
//                             dayPeriodTextColor: Colors.black,
//                             hourMinuteColor: Colors.white,
//                             hourMinuteTextColor: Colors.black,
//                             dialHandColor: Colors.lightBlueAccent,
//                             dayPeriodBorderSide: BorderSide(
//                               color: Colors.lightBlueAccent,
//                               width: 2,
//                             ),
//                           ),
//                         ),
//                         child: child!,
//                       ),
//                     );
//                   },
//                 );

//                 if (time != null) {
//                   setState(() => selectedTime = time);
//                   debugPrint('Time picked: $time');
//                 }
//               },
//             ),
//           ),
//           const SizedBox(height: 20),
//           const Expanded(
//               // 👈 THIS FIXES EVERYTHING
//               child: MealTimeSetterScreen()),
//         ],
//       ),
//     );
//   }
// }

class ExpandableContainerList extends StatefulWidget {
  const ExpandableContainerList({super.key});

  @override
  _ExpandableContainerListState createState() =>
      _ExpandableContainerListState();
}

class _ExpandableContainerListState extends State<ExpandableContainerList> {
  int expandedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 7, // number of cousin containers
        itemBuilder: (context, index) {
          bool isExpanded = expandedIndex == index;
          final days = [
            'Sunday',
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Saturday'
          ];
          return GestureDetector(
            onTap: () {
              setState(() {
                expandedIndex = isExpanded ? -1 : index;
              });
            },
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isExpanded
                      ? Colors.lightBlueAccent
                      : Colors.blueAccent.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                height: isExpanded ? 200 : 80, // toggle height
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          days[index],
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (isExpanded) ...[
                        const SizedBox(height: 16),
                        const Text("More field 1",
                            style: TextStyle(color: Colors.white70)),
                        const Text("More field 2",
                            style: TextStyle(color: Colors.white70)),
                        // Add more widgets here
                      ],
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:firebase_firestore/firebase_firestore.dart';

class MealTimeSetterScreen extends StatefulWidget {
  const MealTimeSetterScreen({super.key});

  @override
  State<MealTimeSetterScreen> createState() => _MealTimeSetterScreenState();
}

class _MealTimeSetterScreenState extends State<MealTimeSetterScreen> {
  final Map<String, Map<String, TimeOfDay>> mealTimings = {
    'Breakfast': {
      'start': const TimeOfDay(hour: 7, minute: 0),
      'end': const TimeOfDay(hour: 9, minute: 0)
    },
    'Lunch': {
      'start': const TimeOfDay(hour: 12, minute: 0),
      'end': const TimeOfDay(hour: 15, minute: 0)
    },
    'Dinner': {
      'start': const TimeOfDay(hour: 19, minute: 0),
      'end': const TimeOfDay(hour: 0, minute: 0)
    },
  };

  Future<void> pickTime(String meal, String type) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: mealTimings[meal]![type]!,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.lightBlueAccent,
              onPrimary: Colors.white,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        mealTimings[meal]![type] = picked;
      });
    }
  }

  Future<void> saveMealTimesToFirestore() async {
    final firestore = FirebaseFirestore.instance;
    for (var meal in mealTimings.entries) {
      await firestore.collection('meals').doc(meal.key.toLowerCase()).set({
        'startTime': formatTime(meal.value['start']!),
        'endTime': formatTime(meal.value['end']!),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Meal times saved successfully!'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  String formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return SingleChildScrollView(
        child: Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Set Meal Times',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent,
                  )),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: mealTimings.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final meal = mealTimings.keys.elementAt(index);
                return _buildMealCard(meal, isSmallScreen);
              },
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: saveMealTimesToFirestore,
              icon: const Icon(Icons.save_rounded),
              label: const Text('SAVE ALL MEAL TIMES'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildMealCard(String meal, bool isSmallScreen) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.restaurant_menu_rounded,
                    color: Colors.lightBlueAccent),
                const SizedBox(width: 12),
                Text(meal,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
            const SizedBox(height: 20),
            isSmallScreen
                ? Column(
                    children: [
                      _buildTimeButton(meal, 'start'),
                      const SizedBox(height: 12),
                      _buildTimeButton(meal, 'end'),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: _buildTimeButton(meal, 'start')),
                      const SizedBox(width: 16),
                      Expanded(child: _buildTimeButton(meal, 'end')),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeButton(String meal, String type) {
    return OutlinedButton(
      onPressed: () => pickTime(meal, type),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: const BorderSide(color: Colors.lightBlueAccent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            type == 'start' ? Icons.alarm_add_rounded : Icons.alarm_off_rounded,
            color: Colors.lightBlueAccent,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            '${type == 'start' ? 'Start' : 'End'}: ${formatTime(mealTimings[meal]![type]!)}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
