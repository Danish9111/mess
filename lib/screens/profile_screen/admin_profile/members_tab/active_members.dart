import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class ActiveMembers extends StatefulWidget {
  const ActiveMembers({super.key});

  @override
  State<ActiveMembers> createState() => _ActiveMembersState();
}

class _ActiveMembersState extends State<ActiveMembers> {
  @override
  void initState() {
    super.initState();
    fetchActiveMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Members'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Active Members'),
      ),
    );
  }
}

Future fetchActiveMembers() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('members')
      .where('isActive', isEqualTo: true)
      .get();
  for (var doc in snapshot.docs) {
    final data = doc.data();
    print(data['name']);
    debugPrint(data['phone']);
  }
}
