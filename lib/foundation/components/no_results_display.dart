import 'package:flutter/material.dart';
import '../theme/stream_palette.dart';
import '../theme/stream_typography.dart';

class NoResultsDisplay extends StatelessWidget {
  const NoResultsDisplay({
    super.key,
    this.title = "Can't find what you're looking for?",
    this.subtitle = 'Try searching for another movie, show, director, or genre.',
    this.icon = Icons.search_off_rounded,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 56,
              color: StreamPalette.textHint,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: StreamTypography.sectionHeader,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: StreamTypography.body,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
