import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central theme definitions for the personal website.
///
/// Light and dark themes are generated from a single seed color and share a
/// consistent typography scale based on Google Fonts.
class AppTheme {
  AppTheme._();

  static const Color _seedColor = Color(0xFF3B82F6);

  static TextTheme _textTheme(Brightness brightness) {
    final base =
        brightness == Brightness.dark
            ? ThemeData.dark().textTheme
            : ThemeData.light().textTheme;

    return GoogleFonts.interTextTheme(base).copyWith(
      displayLarge: GoogleFonts.inter(
        fontSize: 57,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.5,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 45,
        fontWeight: FontWeight.w800,
        letterSpacing: -1,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 26,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.inter(fontSize: 16, height: 1.5),
      bodyMedium: GoogleFonts.inter(fontSize: 14, height: 1.5),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static ThemeData get light => _build(Brightness.light);

  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: brightness,
    );

    final base = ThemeData(
      colorScheme: colorScheme,
      brightness: brightness,
      textTheme: _textTheme(brightness),
    );

    return base.copyWith(
      scaffoldBackgroundColor:
          brightness == Brightness.dark
              ? const Color(0xFF0B0F19)
              : const Color(0xFFF6F8FC),
      cardColor:
          brightness == Brightness.dark
              ? const Color(0xFF121826)
              : Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor:
            brightness == Brightness.dark
                ? const Color(0xFF0B0F19)
                : const Color(0xFFF6F8FC),
        elevation: 0,
        centerTitle: false,
        foregroundColor: colorScheme.onSurface,
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        thickness: 1,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color:
            brightness == Brightness.dark
                ? const Color(0xFF121826)
                : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
