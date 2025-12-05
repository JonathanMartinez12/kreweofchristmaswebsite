import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'palette.dart';

class AppTypography {
  static TextTheme buildTextTheme() {
    final base = GoogleFonts.interTextTheme();

    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontSize: 46,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.2,
        color: Palette.textOnLight,
      ),
      displayMedium: base.displayMedium?.copyWith(
        fontSize: 34,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.1,
        color: Palette.textOnLight,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Palette.textOnLight,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        fontSize: 16,
        height: 1.6,
        color: Palette.textOnLight,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontSize: 14,
        height: 1.5,
        color: Palette.textOnLight,
      ),
    );
  }
}
