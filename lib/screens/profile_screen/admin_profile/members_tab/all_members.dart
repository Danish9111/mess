import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:mess/screens/profile_screen/admin_profile/members_tab/memeber_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class AllMembers extends StatefulWidget {
  const AllMembers({super.key});

  @override
  State<AllMembers> createState() => _MembersTabState();
}

class _MembersTabState extends State<AllMembers> {
  List<Member> _filteredMembers = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredMembers = _members;
    _searchController.addListener(_filterMembers);
    fetchActiveMembers();
  }

  Future fetchActiveMembers() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('members')
          .where('isActive', isEqualTo: true)
          .get();
      log(snapshot.docs.length.toString());
      for (var doc in snapshot.docs) {
        final data = doc.data();
        debugPrint(data['name']);
        debugPrint(data['phone']);
      }
      return snapshot;
    } catch (e) {
      debugPrint(e.toString());
    }
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

  void _deleteMember(String memberId) {
    setState(() {
      _members.removeWhere((member) => member.id == memberId);
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
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          title: const Text('Members'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _showAddMemberDialog,
            ),
          ],
        ),
        body: Column(children: [
          const SizedBox(
            height: 20,
          ),
          // const TotalMembers(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                ),
                hintText: 'Search members...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.cyan,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                filled: true,
                fillColor: Colors.white10,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchActiveMembers(),
              builder: (context, snapshot) => ListView.builder(
                itemCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    elevation: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          snapshot.data?.docs[index]['name'] ?? 'Loading...',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(
                            snapshot.data?.docs[index]["phone"]?.toString() ??
                                'loading..',
                            style: Theme.of(context).textTheme.bodyMedium),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 30,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                color:
                                    // snapshot.data().data?['isActive'] ?? false
                                    //     ? Colors.green
                                    //     : Colors.grey,
                                    Colors.green,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Text(
                                  'Active', // Optional: keep conditional if needed
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                log('pressed');
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      title: const Text('Delete Member'),
                                      content: const Text(
                                          'Are you sure you want to delete this member?'),
                                      actions: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            overlayColor: Colors.grey.shade300,
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('Cancel',
                                              style: TextStyle(
                                                  color: Colors.grey.shade800)),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await deleteMember();
                                          },
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.delete),
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // const SizedBox(height: 16),
          )
        ]));
  }
}
