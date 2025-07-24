import 'package:flutter/material.dart';
import 'package:mess/screens/profile_screen/admin_profile/meal_tab/meal_tab.dart';
import 'package:mess/screens/profile_screen/admin_profile/members_tab/members_tab.dart';
import 'package:mess/screens/profile_screen/admin_profile/timing_tab/timing_tab.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Add a listener to rebuild the widget when the tab changes.
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          title: const Text('Admin Profile'),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.lightBlueAccent,
            indicatorWeight: 3,
            labelColor: Colors.lightBlueAccent,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(fontSize: 15),
            tabs: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text('Meals'),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text('Timings'),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text('Members'),
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            MealTab(),
            MealTimeSetterScreen(),
            MembersTab(),
          ],
        ),
        floatingActionButton: _tabController.index == 2
            ? FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const InviteQRDialog(),
                  );
                },
                backgroundColor: Colors.lightBlueAccent,
                child: const Icon(Icons.qr_code, color: Colors.white),
              )
            : null);
  }
}
