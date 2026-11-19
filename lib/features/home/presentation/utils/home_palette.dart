import 'package:flutter/material.dart';

abstract final class HomePalette {
  static const Color primary = Color(0xFF3D5AFE);
  static const Color primaryEnd = Color(0xFF2979FF);
  static const Color background = Color(0xFFF7F8FC);
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color track = Color(0xFFE8ECF4);
  static const Color income = Color(0xFF00B67A);
  static const Color expense = Color(0xFFFF6B6B);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
