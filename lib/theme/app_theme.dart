import 'package:flutter/material.dart';
import 'palette.dart';
import 'typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final textTheme = AppTypography.buildTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Palette.pageBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Palette.deepGreen,
        brightness: Brightness.light,
        primary: Palette.deepGreen,
        secondary: Palette.accentRed,
        background: Palette.pageBackground,
      ),
      textTheme: textTheme.apply(
        bodyColor: Palette.textOnLight,
        displayColor: Palette.textOnLight,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.accentRed,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Palette.deepGreen, width: 1.5),
          foregroundColor: Palette.deepGreen,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
      cardTheme: CardThemeData(
  color: Palette.surfaceLight,
  elevation: 2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
),);

  }
}
