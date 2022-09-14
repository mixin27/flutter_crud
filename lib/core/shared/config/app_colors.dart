import 'package:flutter/material.dart';

/// Colors used in the application will be defined here.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xff244B98); // #244B98 - 37%
  static const Color primary40 = Color(0xff2751a5); // #2751a5 - 40%
  static const Color primary80 = Color(0xffacc1ec); // #acc1ec - 80%

  static const Color secondary = Color(0xff55C7EB); // #55C7EB - 63%
  static const Color secondary40 = Color(0xff1591b7); // #1591b7 - 40%
  static const Color secondary80 = Color(0xffa4e1f4); // #a4e1f4 - 80%

  static ColorScheme lightColorSchemaFromSeed = ColorScheme.fromSeed(
    seedColor: primary40,
    secondary: secondary40,
    brightness: Brightness.light,
  );

  static ColorScheme darkColorSchemaFromSeed = ColorScheme.fromSeed(
    seedColor: primary80,
    secondary: secondary80,
    brightness: Brightness.dark,
  );

  static ColorScheme lightColorSchema = const ColorScheme.light(
    primary: primary40,
    secondary: secondary40,
  );

  static ColorScheme darkColorSchema = const ColorScheme.dark(
    primary: primary80,
    secondary: secondary80,
  );
}
