import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

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
