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
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                        dayPeriodColor:
                            Colors.lightBlueAccent, // <- AM/PM background
                        dayPeriodTextColor: Colors.white, // <- AM/PM text
                        hourMinuteColor: Colors.white,
                        hourMinuteTextColor: Colors.black,
                      ),
                    ),
                    child: child!,
                  ),
                );
              },
              hourLabelText: 'Hours',
              minuteLabelText: 'Minutes',
            );

            if (time != null) {
              setState(() => selectedTime = time);
              debugPrint('Time picked: $time');
            }
          },
        ),
      ),
    );
  }
}
