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
                child: Text('dashboard'),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('expense'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
