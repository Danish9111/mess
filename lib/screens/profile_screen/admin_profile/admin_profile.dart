import 'package:flutter/material.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // 3 tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mess Admin Panel'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Meals'),
              Tab(text: 'Users'),
              Tab(text: 'Billing'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MealsTab(),
            UsersTab(),
            BillingTab(),
          ],
        ),
      ),
    );
  }
}

// Meals Tab
class MealsTab extends StatelessWidget {
  const MealsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Manage Daily Meals Here'),
    );
  }
}

// Users Tab
class UsersTab extends StatelessWidget {
  const UsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('View & Manage Users'),
    );
  }
}

// Billing Tab
class BillingTab extends StatelessWidget {
  const BillingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Billing & Payments Info'),
    );
  }
}
