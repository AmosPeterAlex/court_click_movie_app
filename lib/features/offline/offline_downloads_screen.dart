import 'package:flutter/material.dart';
import '../../foundation/theme/stream_palette.dart';
import '../../foundation/theme/stream_typography.dart';

class OfflineDownloadsScreen extends StatelessWidget {
  const OfflineDownloadsScreen({
    super.key,
    this.onFindSomethingToDownload,
  });

  final VoidCallback? onFindSomethingToDownload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StreamPalette.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Smart Downloads',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: StreamPalette.textPrimary,
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
              style: StreamTypography.headline.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 12),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit quam dui, vivamus bibendum ut. A morbi mi tortor ut felis non accumsan accumsan quis. Massa, id ut ipsum aliquam enim non posuere pulvinar diam.',
              style: StreamTypography.bodySmall.copyWith(
                color: StreamPalette.textSecondary,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 36),
            Center(
              child: Container(
                width: 230,
                height: 230,
                decoration: const BoxDecoration(
                  color: StreamPalette.placeholderCircle,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.download_rounded,
                    size: 64,
                    color: StreamPalette.textHint,
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
                    color: StreamPalette.secondaryButtonBg,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Text(
                    'Find Something to Download',
                    style: TextStyle(
                      color: Colors.white,
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
