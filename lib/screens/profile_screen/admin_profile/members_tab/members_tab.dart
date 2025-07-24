import 'package:flutter/material.dart';
import 'package:mess/screens/profile_screen/admin_profile/members_tab/build_member_tab_body.dart';
import 'package:mess/screens/profile_screen/admin_profile/members_tab/invite_qr_dialog.dart';

class MembersTab extends StatelessWidget {
  const MembersTab({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: buildMemberTabBody(context, screenHeight, screenWidth),
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
    );
  }
}
