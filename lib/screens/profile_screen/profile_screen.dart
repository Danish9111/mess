import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mess/screens/profile_screen/profileHeader/buildProfileHeader.dart';
import 'package:mess/screens/profile_screen/buildProgressSection.dart';
import 'package:mess/screens/profile_screen/buildMealActivity.dart';
import 'package:mess/screens/profile_screen/buildWalletSection.dart';
import 'package:mess/screens/profile_screen/buildFeedback.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
  const ProfileScreen({super.key});
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('',
            style: TextStyle(
                color: Colors.lightBlueAccent[700],
                fontWeight: FontWeight.bold)),
        // backgroundColor: Colors.lightBlueAccent,
        flexibleSpace: Container(
            decoration: const BoxDecoration(color: Colors.lightBlueAccent)),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildProfileHeader(context, ref),
            buildProgressSection(context),
            buildMealActivity(),
            buildWalletSection(),
            buildFeedback('1', '2'),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
