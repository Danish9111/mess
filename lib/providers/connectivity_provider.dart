import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' if (dart.library.html) 'dart:html' as io;

// final isOnline = InternetConnectionChecker().hasConnection;

final internetProvider = StreamProvider<InternetConnectionStatus>(
    (ref) => InternetConnectionChecker.instance.onStatusChange);
final instantNetProvider = StreamProvider<bool>((ref) async* {
  // first emit immediately
  yield await ping();

  // then keep emitting every 2 s (or whatever)
  final timer = Stream.periodic(const Duration(seconds: 2));
  await for (final _ in timer) {
    yield await ping();
  }
});

Future<bool> ping() async {
  if (kIsWeb) return false; // or use a fallback HTTP ping for web

  try {
    final s = await io.Socket.connect('1.1.1.1', 53,
        timeout: const Duration(milliseconds: 150));
    s.destroy();
    return true;
  } on io.SocketException {
    return false;
  }
}
