import 'package:flutter/material.dart';
import 'stream_palette.dart';

abstract final class StreamTypography {
  static const TextStyle displayLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: StreamPalette.textPrimary,
    letterSpacing: -0.5,
  );

  static const TextStyle headline = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: StreamPalette.textPrimary,
    letterSpacing: -0.3,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: StreamPalette.textPrimary,
  );

  static const TextStyle sectionHeader = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: StreamPalette.textPrimary,
    letterSpacing: 0.2,
  );

  static const TextStyle topNavAction = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: StreamPalette.textPrimary,
    shadows: [
      Shadow(
        blurRadius: 4,
        color: Colors.black54,
        offset: Offset(0, 1),
      ),
    ],
  );

  static const TextStyle tileTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: StreamPalette.textPrimary,
    height: 1.25,
  );

  static const TextStyle buttonLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
  );

  static const TextStyle heroButtonLabel = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle heroSmallAction = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: StreamPalette.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: StreamPalette.textSecondary,
    height: 1.4,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 11.5,
    fontWeight: FontWeight.normal,
    color: StreamPalette.textSecondary,
    height: 1.4,
  );

  static const TextStyle genreTags = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: StreamPalette.textSecondary,
    letterSpacing: 0.2,
  );

  static const TextStyle badgeText = TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.w900,
    color: StreamPalette.textPrimary,
    letterSpacing: 0.5,
  );

  static const TextStyle ratingText = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: StreamPalette.ratingGreen,
  );

  static const TextStyle dateNotice = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: StreamPalette.textSecondary,
  );
}
