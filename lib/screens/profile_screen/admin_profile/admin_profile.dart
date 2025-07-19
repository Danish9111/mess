import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MessPro Admin',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.lightBlue,
          accentColor: Colors.lightBlueAccent,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 1,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.lightBlueAccent,
        ),
      ),
      home: const MainDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const MealManagementScreen(),
    const UserManagementScreen(),
    const AttendanceScreen(),
    const FeedbackScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MessPro Admin'),
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          IconButton(
              icon: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/nashtapng.png')),
              onPressed: () {}),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.lightBlueAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu), label: 'Meals'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
          BottomNavigationBarItem(
              icon: Icon(Icons.checklist), label: 'Attendance'),
          BottomNavigationBarItem(
              icon: Icon(Icons.feedback), label: 'Feedback'),
        ],
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

// Meal Management Module
class MealManagementScreen extends StatefulWidget {
  const MealManagementScreen({super.key});

  @override
  MealManagementScreenState createState() => MealManagementScreenState();
}

class MealManagementScreenState extends State<MealManagementScreen> {
  final List<Map<String, dynamic>> _meals = [
    {
      'id': '1',
      'name': 'Vegetable Pasta',
      'type': 'Lunch',
      'calories': 420,
      'active': true
    },
    {
      'id': '2',
      'name': 'Chicken Sandwich',
      'type': 'Breakfast',
      'calories': 320,
      'active': false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Meal Management',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add Meal'),
                onPressed: () => _showMealForm(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _meals.length,
            itemBuilder: (context, index) => _buildMealCard(_meals[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildMealCard(Map<String, dynamic> meal) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading:
            const CircleAvatar(backgroundImage: AssetImage('assets/meal.jpg')),
        title: Text(meal['name']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${meal['type']} • ${meal['calories']} kcal'),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              children: [
                Chip(
                    label: Text(meal['active'] ? 'Active' : 'Inactive',
                        style: TextStyle(
                            color:
                                meal['active'] ? Colors.green : Colors.red))),
                const Chip(
                    label: Text('Veg', style: TextStyle(color: Colors.green))),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                icon: const Icon(Icons.edit, color: Colors.lightBlue),
                onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }

  void _showMealForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const MealForm(),
    );
  }
}

class MealForm extends StatefulWidget {
  const MealForm({super.key});

  @override
  MealFormState createState() => MealFormState();
}

class MealFormState extends State<MealForm> {
  // Form state management here
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Add New Meal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextFormField(
              decoration: const InputDecoration(labelText: 'Meal Name')),
          TextFormField(
              decoration: const InputDecoration(labelText: 'Description')),
          TextFormField(
              decoration: const InputDecoration(labelText: 'Ingredients')),
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Calories'))),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(
                        value: 'Breakfast', child: Text('Breakfast')),
                    DropdownMenuItem(value: 'Lunch', child: Text('Lunch')),
                    DropdownMenuItem(value: 'Dinner', child: Text('Dinner')),
                  ],
                  decoration: const InputDecoration(labelText: 'Meal Type'),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlueAccent,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Save Meal'),
          ),
        ],
      ),
    );
  }
}

// User Management Module
class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('User Management',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search users...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => const UserListItem(),
          ),
        ),
      ],
    );
  }
}

class UserListItem extends StatelessWidget {
  const UserListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: const Text('Rahul Sharma'),
        subtitle: const Text('Room 205 • Roll No: 2023001'),
        trailing: Switch(
          value: true,
          activeColor: Colors.lightBlueAccent,
          onChanged: (value) {},
        ),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UserDetailScreen())),
      ),
    );
  }
}

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
                child: CircleAvatar(
                    radius: 50, child: Icon(Icons.person, size: 50))),
            const SizedBox(height: 20),
            const Text('Rahul Sharma',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text('Room 205 • Roll No: 2023001'),
            const Divider(height: 30),
            const Text('Dietary Preference: Vegetarian',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            const Text('Meals Skipped: 3 this week',
                style: TextStyle(color: Colors.red)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent),
                  child: const Text('View History'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Block User'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Attendance Module
class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Today\'s Attendance',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent),
                child: const Text('Mark Attendance'),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                  child: _AttendanceStatCard(
                      title: 'Total', value: '320', color: Colors.blue)),
              SizedBox(width: 10),
              Expanded(
                  child: _AttendanceStatCard(
                      title: 'Present', value: '285', color: Colors.green)),
              SizedBox(width: 10),
              Expanded(
                  child: _AttendanceStatCard(
                      title: 'Absent', value: '35', color: Colors.red)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Expanded(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: 'Breakfast'),
                    Tab(text: 'Lunch'),
                    Tab(text: 'Dinner'),
                  ],
                  indicatorColor: Colors.lightBlueAccent,
                  labelColor: Colors.lightBlueAccent,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Center(child: Text('Breakfast Attendance Data')),
                      Center(child: Text('Lunch Attendance Data')),
                      Center(child: Text('Dinner Attendance Data')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AttendanceStatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _AttendanceStatCard(
      {required this.title, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(title,
                style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(value,
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}

// Feedback Module
class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Meal Feedback',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent),
                child: const Text('Generate Report'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => const FeedbackCard(),
          ),
        ),
      ],
    );
  }
}

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 20, child: Icon(Icons.person)),
                const SizedBox(width: 10),
                const Text('Rahul Sharma',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                Row(
                  children: List.generate(
                      5,
                      (i) => Icon(
                            Icons.star,
                            color: i < 4 ? Colors.amber : Colors.grey,
                            size: 20,
                          )),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text('Vegetable Pasta - Lunch',
                style: TextStyle(color: Colors.blueGrey)),
            const SizedBox(height: 10),
            const Text(
                'The pasta was excellent today! Perfectly cooked with fresh vegetables. Would love to have this more often.'),
            const SizedBox(height: 10),
            Row(
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.reply, color: Colors.lightBlueAccent),
                  label: const Text('Reply',
                      style: TextStyle(color: Colors.lightBlueAccent)),
                  onPressed: () {},
                ),
                const Spacer(),
                TextButton(
                  child:
                      const Text('Flag', style: TextStyle(color: Colors.red)),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
