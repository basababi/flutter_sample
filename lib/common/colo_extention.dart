import 'package:flutter/material.dart';

class TColor {
  static Color get primaryColor1 => const Color(0xFF562E98);
  static Color get primaryColor2 => const Color(0xFF804FD0);

  static Color get secondaryColor1 => const Color.fromARGB(255, 165, 144, 182);
  static Color get secondaryColor2 => const Color(0xFFEEA4CE);

  static List<Color> get primaryGradientColors => [
    primaryColor1,
    primaryColor2,
  ];
  static List<Color> get secondaryGradientColors => [
    secondaryColor1,
    secondaryColor2,
  ];

  static Color get blackColor => const Color(0xFF1D1617);
  static Color get grayColor => const Color(0xFF786F72);
  static Color get whiteColor => Colors.white;
}
