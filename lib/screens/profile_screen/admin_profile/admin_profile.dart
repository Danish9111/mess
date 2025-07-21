import 'package:flutter/material.dart';

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
          TimePicker24Hour(),
          Center(child: Text('expense'))
        ]),
      ),
    );
  }
}

class TimePicker24Hour extends StatefulWidget {
  const TimePicker24Hour({super.key});

  @override
  State<TimePicker24Hour> createState() => _TimePicker24HourState();
}

class _TimePicker24HourState extends State<TimePicker24Hour> {
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                selectedTime != null
                    ? '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}'
                    : 'Pick Time',
              ),
              onPressed: () async {
                final TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (context, child) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: false),
                      child: Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Colors.blueAccent,
                            onPrimary: Colors.white,
                            surface: Colors.white,
                            onSurface: Colors.black87,
                          ),
                          dialogBackgroundColor: Colors.white,
                          timePickerTheme: const TimePickerThemeData(
                            dayPeriodColor: Colors.lightBlueAccent,
                            dayPeriodTextColor: Colors.black,
                            hourMinuteColor: Colors.white,
                            hourMinuteTextColor: Colors.black,
                            dialHandColor: Colors.lightBlueAccent,
                            dayPeriodBorderSide: BorderSide(
                              color: Colors.lightBlueAccent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: child!,
                      ),
                    );
                  },
                );

                if (time != null) {
                  setState(() => selectedTime = time);
                  debugPrint('Time picked: $time');
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          const Expanded(
            // 👈 THIS FIXES EVERYTHING
            child: ExpandableContainerList(),
          ),
        ],
      ),
    );
  }
}

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
                  color: Colors.lightBlueAccent,
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
