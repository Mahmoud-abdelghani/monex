import 'dart:convert';

import 'package:crypto/crypto.dart';

class NotificationIdMapper {
  const NotificationIdMapper();

  static int map(String id) {
    final bytes = utf8.encode(id);
    final digest = sha256.convert(bytes);

    return digest.bytes
            .take(4)
            .fold<int>(0, (value, byte) => (value << 8) | byte) &
        0x7fffffff;
  }
}
