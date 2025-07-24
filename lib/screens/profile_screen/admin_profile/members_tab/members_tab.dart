import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

// ======================== DATA MODELS ========================
enum MealPlan { breakfastOnly, lunchOnly, dinnerOnly, allMeals, custom }

enum DietaryPreference {
  vegetarian,
  vegan,
  glutenFree,
  halal,
  kosher,
  dairyFree
}

enum MealType { breakfast, lunch, dinner }

extension MealPlanExtension on MealPlan {
  String get label {
    switch (this) {
      case MealPlan.breakfastOnly:
        return 'Breakfast Only';
      case MealPlan.lunchOnly:
        return 'Lunch Only';
      case MealPlan.dinnerOnly:
        return 'Dinner Only';
      case MealPlan.allMeals:
        return 'All Meals';
      case MealPlan.custom:
        return 'Custom Plan';
    }
  }
}

class Member {
  final String id;
  final String name;
  final String role;
  final String? profileImageUrl;
  final bool isActive;
  final MealPlan mealPlan;
  final String contact;
  final String cnic;
  final DateTime joinDate;
  final List<DietaryPreference> dietaryPreferences;
  final String adminNotes;
  final int totalMealsThisMonth;
  final DateTime? lastMealEntry;
  final Map<MealType, bool> todayMeals;
  final int mealQuotaTotal;
  final int mealQuotaUsed;

  Member({
    required this.id,
    required this.name,
    required this.role,
    this.profileImageUrl,
    this.isActive = true,
    required this.mealPlan,
    required this.contact,
    required this.cnic,
    required this.joinDate,
    this.dietaryPreferences = const [],
    this.adminNotes = '',
    this.totalMealsThisMonth = 0,
    this.lastMealEntry,
    Map<MealType, bool>? todayMeals,
    this.mealQuotaTotal = 30,
    this.mealQuotaUsed = 0,
  }) : todayMeals = todayMeals ??
            {
              MealType.breakfast: false,
              MealType.lunch: false,
              MealType.dinner: false,
            };

  String get formattedJoinDate => DateFormat.yMMMd().format(joinDate);
  String get initials => name.split(' ').map((e) => e[0]).take(2).join();
  int get remainingQuota => mealQuotaTotal - mealQuotaUsed;
  bool get isLowQuota => remainingQuota <= 3;
  double get quotaPercentage => mealQuotaUsed / mealQuotaTotal;
}

// ======================== MAIN MEMBERS SCREEN ========================
class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  List<Member> members = [];
  List<Member> filteredMembers = [];
  TextEditingController searchController = TextEditingController();
  String selectedFilter = 'All';
  bool showActiveOnly = true;
  MealPlan? selectedMealPlan;

  @override
  void initState() {
    super.initState();
    _loadMockMembers();
    searchController.addListener(_filterMembers);
  }

  void _loadMockMembers() {
    setState(() {
      members = [
        Member(
          id: '001',
          name: 'Ali Ahmed',
          role: 'Student',
          mealPlan: MealPlan.allMeals,
          contact: 'ali@example.com',
          cnic: '42101-1234567-8',
          joinDate: DateTime(2023, 1, 15),
          dietaryPreferences: [DietaryPreference.halal],
          totalMealsThisMonth: 22,
          lastMealEntry: DateTime.now(),
          todayMeals: {
            MealType.breakfast: true,
            MealType.lunch: false,
            MealType.dinner: false,
          },
          mealQuotaUsed: 22,
        ),
        Member(
          id: '002',
          name: 'Sara Khan',
          role: 'Faculty',
          profileImageUrl: null,
          isActive: false,
          mealPlan: MealPlan.breakfastOnly,
          contact: 'sara@example.com',
          cnic: '42201-7654321-1',
          joinDate: DateTime(2024, 3, 10),
          dietaryPreferences: [
            DietaryPreference.vegetarian,
            DietaryPreference.glutenFree
          ],
          adminNotes: 'Prefers gluten-free options',
          totalMealsThisMonth: 8,
          mealQuotaUsed: 8,
        ),
      ];
      filteredMembers = members;
    });
  }

  void _filterMembers() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredMembers = members.where((member) {
        final nameMatch = member.name.toLowerCase().contains(query);
        final idMatch = member.id.toLowerCase().contains(query);
        final statusMatch = showActiveOnly ? member.isActive : true;
        final mealPlanMatch =
            selectedMealPlan == null || member.mealPlan == selectedMealPlan;
        return (nameMatch || idMatch) && statusMatch && mealPlanMatch;
      }).toList();
    });
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Filters',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Divider(),
                  SwitchListTile(
                    title: const Text('Active Members Only'),
                    value: showActiveOnly,
                    onChanged: (value) =>
                        setState(() => showActiveOnly = value),
                  ),
                  DropdownButtonFormField<MealPlan>(
                    value: selectedMealPlan,
                    decoration: const InputDecoration(labelText: 'Meal Plan'),
                    items: MealPlan.values.map((plan) {
                      return DropdownMenuItem(
                        value: plan,
                        child: Text(plan.label),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => selectedMealPlan = value),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _filterMembers();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Apply Filters'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showExportOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.grid_on),
              title: const Text('Export Member Data (CSV)'),
              onTap: () {
                Navigator.pop(context);
                // _exportCSV();
              },
            ),
            ListTile(
              leading: const Icon(Icons.summarize),
              title: const Text('Export Monthly Summary'),
              onTap: () {
                Navigator.pop(context);
                // Implement monthly summary export
              },
            ),
          ],
        );
      },
    );
  }

  // Future<void> _exportCSV() async {
  //   final csvData = const ListToCsvConverter().convert([
  //     ['ID', 'Name', 'Role', 'Status', 'Meal Plan', 'Join Date', 'Contact'],
  //     ...filteredMembers.map((m) => [
  //           m.id,
  //           m.name,
  //           m.role,
  //           m.isActive ? 'Active' : 'Inactive',
  //           m.mealPlan.label,
  //           m.formattedJoinDate,
  //           m.contact
  //         ])
  //   ]);

  //   try {
  //     final directory = await getTemporaryDirectory();
  //     final file = File(
  //         '${directory.path}/messmate_members_${DateTime.now().millisecondsSinceEpoch}.csv');
  //     await file.writeAsString(csvData);
  //     await Share.shareFiles([file.path], text: 'Messmate Members Export');
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Export failed: $e')),
  //     );
  //   }
  // }

  void _navigateToMemberDetail(Member member) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MemberDetailScreen(member: member),
        ));
  }

  void _showAddMemberDialog() {
    // In a real app, this would navigate to a form screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Add member functionality would open a form')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterOptions(context),
          ),
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: _showExportOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by name or ID...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMembers.length,
              itemBuilder: (context, index) {
                final member = filteredMembers[index];
                return MemberListItem(
                  member: member,
                  onTap: () => _navigateToMemberDetail(member),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMemberDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ======================== MEMBER LIST ITEM ========================
class MemberListItem extends StatelessWidget {
  final Member member;
  final VoidCallback onTap;

  const MemberListItem({super.key, required this.member, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: member.profileImageUrl != null
              ? NetworkImage(member.profileImageUrl!)
              : null,
          child: member.profileImageUrl == null
              ? Text(member.initials, style: const TextStyle(fontSize: 16))
              : null,
        ),
        title: Text(member.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${member.role} • ${member.mealPlan.label}'),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: member.isActive ? Colors.green : Colors.grey,
                  ),
                ),
                const SizedBox(width: 6),
                Text(member.isActive ? 'Active' : 'Inactive',
                    style: const TextStyle(color: Colors.grey)),
                if (member.isLowQuota) ...[
                  const SizedBox(width: 12),
                  const Icon(Icons.warning, color: Colors.orange, size: 16),
                  const SizedBox(width: 4),
                  const Text('Low Quota',
                      style: TextStyle(color: Colors.orange)),
                ]
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

// ======================== MEMBER DETAIL SCREEN ========================
class MemberDetailScreen extends StatelessWidget {
  final Member member;

  const MemberDetailScreen({super.key, required this.member});

  void _editMember(BuildContext context) {
    // In a real app, this would navigate to an edit form
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Edit member functionality would open a form')),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Member?'),
        content: Text(
            'Are you sure you want to remove ${member.name} from the system?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Close detail screen
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${member.name} removed')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editMember(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProfileHeader(member: member),
            const SizedBox(height: 24),
            _MealTrackerToday(member: member),
            const SizedBox(height: 24),
            _MemberInformation(member: member),
            const SizedBox(height: 24),
            _AdminNotesSection(member: member),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final Member member;

  const _ProfileHeader({required this.member});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: member.profileImageUrl != null
              ? NetworkImage(member.profileImageUrl!)
              : null,
          child: member.profileImageUrl == null
              ? Text(member.initials, style: const TextStyle(fontSize: 36))
              : null,
        ),
        const SizedBox(height: 16),
        Text(member.name),
        Text(member.role, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Chip(
          label: Text(member.isActive ? 'Active' : 'Inactive'),
          backgroundColor:
              member.isActive ? Colors.green[50] : Colors.grey[200],
          labelStyle: TextStyle(
            color: member.isActive ? Colors.green : Colors.grey[700],
          ),
        ),
      ],
    );
  }
}

class _MealTrackerToday extends StatelessWidget {
  final Member member;

  const _MealTrackerToday({required this.member});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Today's Meals",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                if (member.isLowQuota)
                  const Row(
                    children: [
                      Icon(Icons.warning, color: Colors.orange),
                      SizedBox(width: 4),
                      Text('Low Meal Quota',
                          style: TextStyle(color: Colors.orange)),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _MealStatus(
                    type: MealType.breakfast,
                    taken: member.todayMeals[MealType.breakfast]!),
                _MealStatus(
                    type: MealType.lunch,
                    taken: member.todayMeals[MealType.lunch]!),
                _MealStatus(
                    type: MealType.dinner,
                    taken: member.todayMeals[MealType.dinner]!),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: member.quotaPercentage,
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
              color: member.isLowQuota ? Colors.orange : Colors.green,
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Meal Quota:'),
                Text(
                    '${member.mealQuotaUsed} / ${member.mealQuotaTotal} meals used'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MealStatus extends StatelessWidget {
  final MealType type;
  final bool taken;

  const _MealStatus({required this.type, required this.taken});

  String get mealLabel {
    switch (type) {
      case MealType.breakfast:
        return 'Breakfast';
      case MealType.lunch:
        return 'Lunch';
      case MealType.dinner:
        return 'Dinner';
    }
  }

  IconData get mealIcon {
    switch (type) {
      case MealType.breakfast:
        return Icons.breakfast_dining;
      case MealType.lunch:
        return Icons.lunch_dining;
      case MealType.dinner:
        return Icons.dinner_dining;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: taken ? Colors.green[50] : Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: Icon(mealIcon, color: taken ? Colors.green : Colors.grey),
        ),
        const SizedBox(height: 8),
        Text(mealLabel, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Text(taken ? 'Taken' : 'Pending',
            style: TextStyle(color: taken ? Colors.green : Colors.grey)),
      ],
    );
  }
}

class _MemberInformation extends StatelessWidget {
  final Member member;

  const _MemberInformation({required this.member});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Member Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            _InfoRow(label: 'Contact', value: member.contact),
            _InfoRow(label: 'CNIC', value: _maskCNIC(member.cnic)),
            _InfoRow(label: 'Join Date', value: member.formattedJoinDate),
            _InfoRow(
                label: 'Total Meals (Month)',
                value: member.totalMealsThisMonth.toString()),
            if (member.lastMealEntry != null)
              _InfoRow(
                label: 'Last Meal Entry',
                value:
                    DateFormat('MMM dd, hh:mm a').format(member.lastMealEntry!),
              ),
            const SizedBox(height: 12),
            const Text('Dietary Preferences',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            if (member.dietaryPreferences.isEmpty)
              const Text('None specified', style: TextStyle(color: Colors.grey))
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: member.dietaryPreferences.map((pref) {
                  return Chip(
                    label: Text(
                      pref.toString().split('.').last,
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: Colors.blue[50],
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  String _maskCNIC(String cnic) {
    if (cnic.length < 15) return cnic;
    return '${cnic.substring(0, 5)}*****${cnic.substring(10)}';
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(label, style: TextStyle(color: Colors.grey[600])),
          ),
          Expanded(
              child: Text(value,
                  style: const TextStyle(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}

class _AdminNotesSection extends StatelessWidget {
  final Member member;

  const _AdminNotesSection({required this.member});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Admin Notes',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () {
                    // Implement notes editing
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              member.adminNotes.isEmpty ? 'No notes added' : member.adminNotes,
              style: TextStyle(
                  color: member.adminNotes.isEmpty ? Colors.grey : null),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================== MAIN APP INTEGRATION ========================
void main() => runApp(const MessmateAdminApp());

class MessmateAdminApp extends StatelessWidget {
  const MessmateAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messmate Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.grey[100],
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Messmate Admin'),
            bottom: const TabBar(
              tabs: [
                Icon(Icons.dashboard),
                Tab(icon: Icon(Icons.people)),
                Tab(icon: Icon(Icons.restaurant)),
                Tab(icon: Icon(Icons.settings)),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Center(child: Text('Dashboard')),
              MembersScreen(),
              Center(child: Text('Meals')),
              Center(child: Text('Settings')),
            ],
          ),
        ),
      ),
    );
  }
}
