import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:mess/screens/profile_screen/ui/_buildProfileHeader.dart';
import 'package:mess/screens/profile_screen/ui/buildProgressSection.dart';
import 'package:mess/screens/profile_screen/ui/buildMealActivity.dart';
import 'package:mess/screens/profile_screen/ui/buildWalletSection.dart';
import 'package:mess/screens/profile_screen/ui/buildFeedback.dart';

class ProfileScreen extends StatelessWidget {
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
            // _buildPreferences(),
            buildFeedback('1', '2'),
            // _buildSettings(context),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// 💸 Wallet Section

// 🔄 Preferences Section

// 📊 Feedback Section

// 📱 Settings Section
Widget _buildSettings(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Account Settings",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildSettingsButton(
                Icons.notifications, "Notifications", true, context),
            _buildSettingsButton(Icons.language, "Language", false, context),
            _buildSettingsButton(Icons.share, "Refer a Friend", false, context),
            _buildSettingsButton(Icons.help, "Help Center", false, context),
            _buildSettingsButton(
                Icons.privacy_tip, "Privacy Policy", false, context),
            _buildSettingsButton(Icons.exit_to_app, "Logout", false, context),
          ],
        )
      ],
    ),
  );
}

Widget _buildSettingsButton(
    IconData icon, String text, bool toggle, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.45,
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(icon, color: Colors.lightBlueAccent),
              SizedBox(width: 12),
              Expanded(child: Text(text)),
              if (toggle)
                Switch(
                  value: true,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: Colors.lightBlueAccent,
                  onChanged: (value) {},
                )
            ],
          ),
        ),
      ),
    ),
  );
}
