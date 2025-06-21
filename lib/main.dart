import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'menu.dart';

void main() => runApp(const MessManagementApp());

class MessManagementApp extends StatelessWidget {
  const MessManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mess Manager',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          // textTheme: GoogleFonts.interTextTheme(),
        ),
      ),
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  bool _isEatingToday = true;
  final List<Meal> _todayMeals = [
    Meal(type: 'Breakfast', time: '7:30 - 9:00 AM', menu: 'Poha, Tea, Fruits'),
    Meal(
        type: 'Lunch', time: '12:30 - 2:00 PM', menu: 'Rice, Dal, Sabzi, Roti'),
    Meal(
        type: 'Dinner',
        time: '8:00 - 9:30 PM',
        menu: 'Chicken Curry, Rice, Salad'),
  ];

  // Initialize with placeholders for all nav items
  List<Widget> _pages = [
    Container(),
    Container(),
    Container(),
    Container(),
    Container()
  ];

  @override
  void initState() {
    super.initState();
    _pages[0] = _buildDashboardContent(false); // Will be updated in build
    _pages[1] = MealPlannerScreen();
    // Add other pages as needed for Attendance, Bill, Profile
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;
    _pages[0] = _buildDashboardContent(isDesktop);
    // Safety check
    final int safeIndex = (_currentIndex >= 0 && _currentIndex < _pages.length)
        ? _currentIndex
        : 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mess Manager'),
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          if (isDesktop)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CircleAvatar(child: Text('AK')),
            )
        ],
      ),
      body: _pages[safeIndex],
      bottomNavigationBar: isDesktop ? null : _buildBottomNavBar(),
      drawer: isDesktop ? null : _buildDrawer(),
    );
  }

  // Extracted dashboard content for use in _pages
  Widget _buildDashboardContent(bool isDesktop) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildSectionTitle('Today\'s Meals'),
          const SizedBox(height: 12),
          _buildMealsSection(isDesktop),
          const SizedBox(height: 24),
          _buildAttendanceToggle(),
          const SizedBox(height: 24),
          _buildSectionTitle('Monthly Summary'),
          const SizedBox(height: 12),
          _buildStatsSection(isDesktop),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good morning, Arjun!',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Here\'s your mess update for today',
          style: GoogleFonts.inter(
            color: Colors.grey.shade600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildMealsSection(bool isDesktop) {
    if (isDesktop) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: _todayMeals.length,
        itemBuilder: (context, index) => _mealCard(_todayMeals[index]),
      );
    } else {
      return SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _todayMeals.length,
          itemBuilder: (context, index) => SizedBox(
            width: 280,
            child: _mealCard(_todayMeals[index]),
          ),
        ),
      );
    }
  }

  Widget _mealCard(Meal meal) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  meal.type,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6C63FF),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0EFFF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    meal.time,
                    style: GoogleFonts.inter(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Menu:',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              meal.menu,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Details'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceToggle() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Attendance',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Will you be eating in the mess today?',
                    style: GoogleFonts.inter(fontSize: 15),
                  ),
                ),
                const SizedBox(width: 16),
                Switch(
                  value: _isEatingToday,
                  activeColor: const Color(0xFF6C63FF),
                  onChanged: (value) {
                    setState(() {
                      _isEatingToday = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _isEatingToday
                  ? 'Status: EATING TODAY'
                  : 'Status: SKIPPING TODAY',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                color: _isEatingToday ? Colors.green : Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(bool isDesktop) {
    final stats = [
      {'title': 'Meals This Month', 'value': '42', 'unit': 'meals'},
      {'title': 'Pending Dues', 'value': '₹1,850', 'unit': 'due by 5th'},
    ];

    if (isDesktop) {
      return Row(
        children: [
          Expanded(child: _statCard(stats[0])),
          const SizedBox(width: 16),
          Expanded(child: _statCard(stats[1])),
        ],
      );
    } else {
      return Column(
        children: [
          _statCard(stats[0]),
          const SizedBox(height: 16),
          _statCard(stats[1]),
        ],
      );
    }
  }

  Widget _statCard(Map<String, String> data) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data['title']!,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  data['value']!,
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  data['unit']!,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return NavigationBar(
      selectedIndex: _currentIndex,
      onDestinationSelected: (index) => setState(() => _currentIndex = index),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.restaurant_menu), label: 'Menu'),
        NavigationDestination(
            icon: Icon(Icons.calendar_today), label: 'Attendance'),
        NavigationDestination(icon: Icon(Icons.receipt), label: 'Bill'),
        NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF6C63FF)),
            child: Text('Mess Manager',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          _drawerItem(Icons.restaurant_menu, 'Menu', 1),
          _drawerItem(Icons.calendar_today, 'Attendance', 2),
          _drawerItem(Icons.receipt, 'Bills', 3),
          _drawerItem(Icons.person, 'Profile', 4),
          _drawerItem(Icons.settings, 'Settings', 5),
          _drawerItem(Icons.logout, 'Logout', 6),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: _currentIndex == index,
      onTap: () {
        // Only allow navigation if index is within _pages range
        if (index >= 0 && index < _pages.length) {
          setState(() => _currentIndex = index);
        }
        Navigator.pop(context);
      },
    );
  }
}

class Meal {
  final String type;
  final String time;
  final String menu;

  Meal({required this.type, required this.time, required this.menu});
}
