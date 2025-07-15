import 'package:flutter/material.dart';
import 'package:mess/screens/dashboard_screen/dashboard_utils/confirm_logout.dart';

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
            decoration: BoxDecoration(color: Colors.lightBlueAccent),
            child: Center(
              child: Text('Settings',
                  style: TextStyle(color: Colors.white, fontSize: 30)),
            )),
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('Language'),
          onTap: () async {
            // simple bottom‑sheet language picker
            final locale = await showModalBottomSheet<String>(
              context: context,
              builder: (_) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('English'),
                    onTap: () => Navigator.pop(context, 'en'),
                  ),
                  ListTile(
                    title: const Text('اردو'),
                    onTap: () => Navigator.pop(context, 'ur'),
                  ),
                ],
              ),
            );
            if (locale != null) {
              // TODO: save locale in prefs / provider
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Language set to $locale')));
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Log out'),
          onTap: () {
            confirmLogout(context);
          },
        ),
      ],
    ),
  );
}
