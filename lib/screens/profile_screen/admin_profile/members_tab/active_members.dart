import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ActiveMembers extends StatefulWidget {
  const ActiveMembers({super.key});

  @override
  State<ActiveMembers> createState() => _ActiveMembersState();
}

class _ActiveMembersState extends State<ActiveMembers> {
  @override
  void initState() {
    // TODO: implement initState
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

fetchActiveMembers() async {
  final userId = FirebaseAuth.instance.currentUser?.uid;
}
