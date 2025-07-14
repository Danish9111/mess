import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A StreamProvider that provides real-time updates on the device's
/// connectivity status
///
/// It listens to the stream from the `connectivity_plus` package and
/// rebuilds widgets that are watching it whenever the connection state changes.
final connectivityStreamProvider =
    StreamProvider<List<ConnectivityResult>>((ref) {
  return Connectivity().onConnectivityChanged;
});
