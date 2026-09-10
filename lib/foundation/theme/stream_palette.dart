import 'package:flutter/material.dart';

abstract final class StreamPalette {
  // Core Backgrounds & Surfaces
  static const Color background = Color(0xFF08080A);
  static const Color surface = Color(0xFF141418);
  static const Color surfaceVariant = Color(0xFF222228);
  static const Color surfaceElevated = Color(0xFF1A1A20);

  // Brand Accents
  static const Color primary = Color(0xFFE50914);
  static const Color primaryDark = Color(0xFFB8060F);
  static const Color accent = Color(0xFF0A84FF);

  // Text Hierarchy
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B3B8);
  static const Color textHint = Color(0xFF70757D);
  static const Color textMuted = Color(0xFF55575E);

  // Shimmer Effects
  static const Color shimmerBase = Color(0xFF16161A);
  static const Color shimmerHighlight = Color(0xFF26262E);

  // Component Specific
  static const Color searchBarBg = Color(0xFF1F1F24);
  static const Color searchIconHint = Color(0xFF8E8E93);
  static const Color searchTileBg = Color(0xFF1A1A20);
  static const Color ratingGreen = Color(0xFF34C759);
  static const Color notificationBg = Color(0xFF1C1C22);
  static const Color placeholderCircle = Color(0xFF25252C);
  static const Color secondaryButtonBg = Color(0xFF2C2C34);
  static const Color bottomNavDivider = Color(0xFF1A1A1E);
  static const Color bottomNavBg = Color(0xFF08080A);

  // User Profile Avatars
  static const Color profileBlue = Color(0xFF2979FF);
  static const Color profileYellow = Color(0xFFFFC107);
  static const Color profileRed = Color(0xFFFF3B30);
  static const Color profilePurple = Color(0xFF7B1FA2);

  // Kids Profile Gradient
  static const List<Color> kidsGradient = [
    Color(0xFF8A179E),
    Color(0xFF1E88E5),
    Color(0xFF00ACC1),
    Color(0xFFFFB300),
  ];

  // Social Sharing
  static const Color shareWhatsApp = Color(0xFF25D366);
  static const Color shareFacebook = Color(0xFF1877F2);
  static const Color shareGmail = Color(0xFFEA4335);
}
