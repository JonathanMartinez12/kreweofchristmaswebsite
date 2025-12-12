import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'palette.dart';

class AppTypography {
  static TextTheme buildTextTheme() {
    // Change to Poppins instead of Inter
    final base = GoogleFonts.poppinsTextTheme();

    return base.copyWith(
      // HERO HEADLINE - Much bigger!
      displayLarge: base.displayLarge?.copyWith(
        fontSize: 64,  // Was 46, now 64!
        fontWeight: FontWeight.w800,
        letterSpacing: -1.0,  // Tighter for modern look
        height: 1.1,
        color: Palette.textOnLight,
      ),
      
      // SECTION HEADERS - Bigger!
      displayMedium: base.displayMedium?.copyWith(
        fontSize: 48,  // Was 34, now 48!
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
        height: 1.2,
        color: Palette.textOnLight,
      ),
      
      // SUBHEADINGS
      titleLarge: base.titleLarge?.copyWith(
        fontSize: 28,  // Was 22, now 28!
        fontWeight: FontWeight.w700,
        color: Palette.textOnLight,
      ),
      
      // BODY TEXT - Bigger and more readable!
      bodyLarge: base.bodyLarge?.copyWith(
        fontSize: 18,  // Was 16, now 18!
        height: 1.6,
        fontWeight: FontWeight.w400,
        color: Palette.textOnLight,
      ),
      
      bodyMedium: base.bodyMedium?.copyWith(
        fontSize: 16,  // Was 14, now 16!
        height: 1.5,
        fontWeight: FontWeight.w400,
        color: Palette.textOnLight,
      ),
    );
  }
}