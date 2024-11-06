import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtils {
  static Future<bool> isConnected() async {

    final connectivityResult = await Connectivity().checkConnectivity();

    // First check for network connection
    if (connectivityResult == ConnectivityResult.none) {
      return false; // No network connection at all
    }

    // Try to ping a reliable server to confirm internet access
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true; // Internet is accessible
      }
    } on SocketException catch (_) {
      return false; // Network available, but no internet access
    }
    return false;
  }
}