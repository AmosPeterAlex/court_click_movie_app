import 'package:flutter/material.dart';
import '../../foundation/theme/stream_palette.dart';

class OfflineDownloadsScreen extends StatelessWidget {
  const OfflineDownloadsScreen({
    super.key,
    this.onFindSomethingToDownload,
  });

  final VoidCallback? onFindSomethingToDownload;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Smart Downloads',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Introducing Downloads For You',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit quam dui, vivamus bibendum ut. A morbi mi tortor ut felis non accumsan accumsan quis. Massa, id ut ipsum aliquam enim non posuere pulvinar diam.',
              style: TextStyle(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                fontSize: 13,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 36),
            Center(
              child: Container(
                width: 230,
                height: 230,
                decoration: BoxDecoration(
                  color: isDark ? StreamPalette.placeholderCircle : const Color(0xFFE5E5EA),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.download_rounded,
                    size: 64,
                    color: isDark ? StreamPalette.textHint : const Color(0xFF8E8E93),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0071EB),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                child: const Text(
                  'SETUP',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Center(
              child: InkWell(
                onTap: onFindSomethingToDownload,
                borderRadius: BorderRadius.circular(3),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: isDark ? StreamPalette.secondaryButtonBg : const Color(0xFFE5E5EA),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    'Find Something to Download',
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
