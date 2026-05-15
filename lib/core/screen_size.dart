import 'package:flutter/material.dart';

class ScreenSize {
  static late double width;
  static late double height;

  static void init(BuildContext context) {
    ScreenSize.width = MediaQuery.of(context).size.width;
    ScreenSize.height = MediaQuery.of(context).size.height;
  }
}
