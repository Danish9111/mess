import 'package:flutter/material.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MessHub Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFFf9f9f9),
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(color: Color(0xFF2c3e50)),
        ),
      ),
      home: const AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final int _selectedIndex = 0;
  String messName = "Delicious Mess";
  String ownerName = "John Doe";
  String email = "john@deliciousmess.com";
  String phone = "+1 (555) 123-4567";

  final List<Map<String, dynamic>> stats = [
    {
      "title": "Total Subscribers",
      "value": "142",
      "icon": Icons.people,
      "color": Colors.green
    },
    {
      "title": "Meals Served Today",
      "value": "87",
      "icon": Icons.restaurant,
      "color": Colors.orange
    },
    {
      "title": "Weekly Earnings",
      "value": "₹15,680",
      "icon": Icons.attach_money,
      "color": Colors.green
    },
    {
      "title": "Pending Orders",
      "value": "12",
      "icon": Icons.access_time,
      "color": Colors.blue
    },
  ];

  final List<Map<String, dynamic>> editableOptions = [
    {"title": "Edit Profile", "icon": Icons.edit, "color": Colors.blue},
    {"title": "Change Logo", "icon": Icons.image, "color": Colors.purple},
    {
      "title": "Update Location",
      "icon": Icons.location_on,
      "color": Colors.red
    },
    {"title": "Update Contact", "icon": Icons.phone, "color": Colors.teal},
  ];

  final List<Map<String, dynamic>> quickActions = [
    {"title": "View Reports", "icon": Icons.bar_chart, "color": Colors.indigo},
    {
      "title": "Manage Meals",
      "icon": Icons.restaurant_menu,
      "color": Colors.orange
    },
    {"title": "User Messages", "icon": Icons.message, "color": Colors.blue},
    {"title": "System Settings", "icon": Icons.settings, "color": Colors.grey},
  ];

  final List<Map<String, dynamic>> securityOptions = [
    {"title": "Change Password", "icon": Icons.lock, "color": Colors.blue},
    {"title": "Logout", "icon": Icons.logout, "color": Colors.blue},
    {"title": "Delete Account", "icon": Icons.delete, "color": Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style:
              TextStyle(color: Color(0xFF2c3e50), fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Color(0xFF2c3e50)),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.orange[300],
              child: const Text('JD', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Info Card
            _buildBasicInfoCard(),
            const SizedBox(height: 20),

            // Stats Overview
            const Text(
              "Mess Stats Overview",
            ),
            const SizedBox(height: 10),
            _buildStatsGrid(),
            const SizedBox(height: 20),

            // Editable Sections
            const Text(
              "Editable Sections",
            ),
            const SizedBox(height: 10),
            _buildEditableGrid(),
            const SizedBox(height: 20),

            // Quick Actions
            const Text(
              "Quick Actions",
            ),
            const SizedBox(height: 10),
            _buildQuickActionsGrid(),
            const SizedBox(height: 20),

            // Security Options
            const Text(
              "Security Options",
            ),
            const SizedBox(height: 10),
            _buildSecurityOptions(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Basic Information",
                    style: Theme.of(context).textTheme.titleLarge),
                const Icon(Icons.info, color: Colors.orange, size: 28),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&h=500&q=80"),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.edit,
                            size: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(messName,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text("Owner: $ownerName"),
                      Text("Email: $email"),
                      Text("Phone: $phone"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text("Add new members by sending them an invitation:"),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter email address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];

        return Card(
          elevation: 5,
          color: Colors.white,
          shadowColor: Colors.grey.shade100,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(stat["icon"], size: 32, color: stat["color"]),
                const SizedBox(height: 10),
                Text(stat["value"],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                Text(stat["title"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEditableGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: editableOptions.length,
      itemBuilder: (context, index) {
        final option = editableOptions[index];
        return Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.blue[50],
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(option["icon"], size: 32, color: option["color"]),
                  const SizedBox(height: 10),
                  Text(option["title"],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickActionsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: quickActions.length,
      itemBuilder: (context, index) {
        final action = quickActions[index];
        return Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.green[50],
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(action["icon"], size: 32, color: action["color"]),
                  const SizedBox(height: 10),
                  Text(action["title"],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSecurityOptions() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: securityOptions.map((option) {
          return ListTile(
            leading: Icon(option["icon"], color: option["color"]),
            title: Text(option["title"]),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              if (option["title"] == "Delete Account") {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Delete Account"),
                    content: const Text(
                        "Are you sure you want to delete your account? This action cannot be undone."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text("Confirm Deletion"),
                              content: const Text(
                                  "This will permanently delete all your data. Please confirm again."),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Account deletion process initiated")),
                                    );
                                  },
                                  child: const Text("Delete",
                                      style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text("Delete",
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        }).toList(),
      ),
    );
  }
}
