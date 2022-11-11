import 'dart:io' show InternetAddress, SocketException;

import 'package:flutter/material.dart' show immutable;

@immutable
class NetworkInfo {
  const NetworkInfo();

  Future<bool> get isConnected async {
    try {
      final result = await InternetAddress.lookup('example.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }

      return false;
    } on SocketException catch (_) {
      return false;
    }
  }
}
