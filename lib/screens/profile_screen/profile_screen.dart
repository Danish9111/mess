import 'package:flutter/material.dart';

import 'package:mess/screens/profile_screen/ui/_buildProfileHeader.dart';
import 'package:mess/screens/profile_screen/ui/buildProgressSection.dart';
import 'package:mess/screens/profile_screen/ui/buildMealActivity.dart';
import 'package:mess/screens/profile_screen/ui/buildWalletSection.dart';
import 'package:mess/screens/profile_screen/ui/buildFeedback.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
        flexibleSpace:
            Container(decoration: BoxDecoration(color: Colors.lightBlueAccent)),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildProfileHeader(context),
            buildProgressSection(context),
            buildMealActivity(),
            buildWalletSection(),
            buildFeedback('1', '2'),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
