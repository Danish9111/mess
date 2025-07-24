import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Messmate Admin'),
          bottom: const TabBar(
            tabs: [Tab(text: 'Members')],
          ),
        ),
        body: const TabBarView(
          children: [MembersTab()],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => const InviteQRDialog(),
            );
          },
          backgroundColor: Colors.lightBlueAccent,
          child: const Icon(Icons.qr_code),
        ),
      ),
    );
  }
}

class Member {
  final String id;
  String name;
  String phone;
  int totalMeals;
  bool isActive;

  Member({
    required this.id,
    required this.name,
    required this.phone,
    this.totalMeals = 0,
    this.isActive = true,
  });
}

class MembersTab extends StatefulWidget {
  const MembersTab({super.key});

  @override
  State<MembersTab> createState() => _MembersTabState();
}

class _MembersTabState extends State<MembersTab> {
  final List<Member> _members = [
    Member(id: '1', name: 'John Doe', phone: '+1234567890', totalMeals: 24),
    Member(
        id: '2',
        name: 'Jane Smith',
        phone: '+0987654321',
        totalMeals: 18,
        isActive: false),
    Member(id: '3', name: 'Bob Johnson', phone: '+1122334455', totalMeals: 32),
  ];
  List<Member> _filteredMembers = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredMembers = _members;
    _searchController.addListener(_filterMembers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterMembers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredMembers = _members.where((member) {
        return member.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _addMember(String name, String phone) {
    setState(() {
      _members.add(Member(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        phone: phone,
      ));
    });
    _filterMembers();
  }

  void _deleteMember(String id) {
    setState(() {
      _members.removeWhere((member) => member.id == id);
    });
    _filterMembers();
  }

  void _showAddMemberDialog() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Member'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  phoneController.text.isNotEmpty) {
                _addMember(nameController.text, phoneController.text);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlueAccent,
            ),
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search members...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredMembers.length,
            itemBuilder: (context, index) {
              final member = _filteredMembers[index];
              return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  elevation: 1,
                  child: ListTile(
                    title: Text(member.name),
                    subtitle: Text(member.phone),
                    trailing: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: member.isActive ? Colors.green : Colors.red,
                      ),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MemberDetailsScreen(
                          member: member,
                          onDelete: () => _deleteMember(member.id),
                        ),
                      ),
                    ),
                  ));
            },
          ),
        ),
      ],
    );
  }
}

class MemberDetailsScreen extends StatelessWidget {
  final Member member;
  final VoidCallback onDelete;

  const MemberDetailsScreen({
    super.key,
    required this.member,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(member.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Member'),
                  content:
                      Text('Are you sure you want to delete ${member.name}?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        onDelete();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Delete',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Name', member.name),
            _buildDetailRow('Phone', member.phone),
            _buildDetailRow('Total Meals', member.totalMeals.toString()),
            _buildDetailRow('Status', member.isActive ? 'Active' : 'Inactive',
                statusColor: member.isActive ? Colors.green : Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? statusColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InviteQRDialog extends StatelessWidget {
  const InviteQRDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final String inviteLink = 'https://messmate.app/invite?code=123456';

    return AlertDialog(
      backgroundColor: Colors.grey[100],
      title: const Text('Invite Member'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Scan to join Messmate'),
            const SizedBox(height: 16),
            Center(
              child: Container(
                width: 200,
                height: 200,
                color: Colors.white,
                child: QrImageView(
                  data: inviteLink,
                  version: QrVersions.auto,
                  size: 200, // This can stay
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(inviteLink, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Close'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}
