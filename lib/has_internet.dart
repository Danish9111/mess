// import 'dart:io';
// import 'package:flutter/material.dart';

// Future<bool> hasInternet() async {
//   try {
//     final socket = await Socket.connect('1.1.1.1', 53,
//         timeout: const Duration(milliseconds: 150));
//     socket.destroy();
//     return true;
//   } catch (_) {
//     return false;
//   }
// }

// // Usage
// void checkConnectionAndShowMessage(BuildContext context) async {
//   final hasNet = await Future.any([
//     hasInternet(),
//     Future.delayed(const Duration(milliseconds: 300), () => false),
//   ]);

//   if (!hasNet) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("No internet connection")),
//     );
//   } else {
//     // continue your logic
//   }
// }
