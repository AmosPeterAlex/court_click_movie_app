import 'package:flutter/material.dart';
import 'stream_palette.dart';
import 'stream_typography.dart';

abstract final class StreamTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: StreamPalette.background,
      cardColor: StreamPalette.surface,
      dividerColor: StreamPalette.surfaceVariant,
      colorScheme: const ColorScheme.dark(
        primary: StreamPalette.primary,
        secondary: StreamPalette.accent,
        surface: StreamPalette.surface,
        error: StreamPalette.primaryDark,
        onPrimary: StreamPalette.textPrimary,
        onSecondary: StreamPalette.textPrimary,
        onSurface: StreamPalette.textPrimary,
        onError: StreamPalette.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: StreamPalette.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: StreamTypography.sectionHeader,
        iconTheme: IconThemeData(color: StreamPalette.textPrimary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: StreamPalette.bottomNavBg,
        selectedItemColor: StreamPalette.textPrimary,
        unselectedItemColor: StreamPalette.textHint,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: StreamPalette.primary,
          foregroundColor: StreamPalette.textPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          textStyle: StreamTypography.buttonLabel,
        ),
      ),
      iconTheme: const IconThemeData(
        color: StreamPalette.textPrimary,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF7F7F9),
      cardColor: Colors.white,
      dividerColor: const Color(0xFFE5E5EA),
      colorScheme: const ColorScheme.light(
        primary: StreamPalette.primary,
        secondary: StreamPalette.accent,
        surface: Colors.white,
        error: StreamPalette.primaryDark,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF1C1C1E),
        onError: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Color(0xFF1C1C1E),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Color(0xFF1C1C1E)),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: StreamPalette.primary,
        unselectedItemColor: Color(0xFF8E8E93),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: StreamPalette.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          textStyle: StreamTypography.buttonLabel,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF1C1C1E),
      ),
    );
  }
}
