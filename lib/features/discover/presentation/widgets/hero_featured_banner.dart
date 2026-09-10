import 'package:flutter/material.dart';
import 'package:court_click_movie_app/features/discover/domain/media_item.dart';
import 'package:court_click_movie_app/foundation/components/media_thumbnail.dart';
import 'package:court_click_movie_app/foundation/theme/stream_palette.dart';
import 'package:court_click_movie_app/foundation/theme/stream_typography.dart';

class HeroFeaturedBanner extends StatelessWidget {
  const HeroFeaturedBanner({
    super.key,
    required this.item,
    this.onPlayTap,
    this.onInfoTap,
    this.onMyListTap,
  });

  final MediaItem? item;
  final VoidCallback? onPlayTap;
  final VoidCallback? onInfoTap;
  final VoidCallback? onMyListTap;

  @override
  Widget build(BuildContext context) {
    final backdrop = item?.backdropUrl ?? '';

    return SizedBox(
      height: 480,
      child: Stack(
        children: [
          // Background Backdrop Image
          Positioned.fill(
            child: backdrop.isNotEmpty
                ? MediaThumbnail(
                    imageUrl: backdrop,
                    height: 480,
                    width: double.infinity,
                    borderRadius: 0,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/home_banner.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(color: StreamPalette.surface),
                  ),
          ),

          // Multi-stage vertical gradient overlay
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.25, 0.7, 1.0],
                  colors: [
                    Color(0x99000000),
                    Colors.transparent,
                    Color(0x66000000),
                    StreamPalette.background,
                  ],
                ),
              ),
            ),
          ),

          // Top Navigation Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 28,
                    errorBuilder: (_, _, _) => const Text(
                      'N',
                      style: TextStyle(
                        color: StreamPalette.primary,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const Spacer(),
                  _buildNavAction('TV Shows'),
                  const SizedBox(width: 24),
                  _buildNavAction('Movies'),
                  const SizedBox(width: 24),
                  _buildNavAction('My List'),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),

          // Bottom Hero Controls & Information
          Positioned(
            left: 0,
            right: 0,
            bottom: 12,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // TOP 10 in Nigeria Today Pill
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1.2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: const Text(
                        'TOP\n10',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 0.9,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '#2 in Nigeria Today',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(blurRadius: 4, color: Colors.black),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Hero Action Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildHeroIconButton(
                        icon: Icons.add,
                        label: 'My List',
                        onTap: onMyListTap,
                      ),
                      ElevatedButton.icon(
                        onPressed: onPlayTap,
                        icon: const Icon(Icons.play_arrow, color: Colors.black, size: 26),
                        label: const Text(
                          'Play',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      _buildHeroIconButton(
                        icon: Icons.info_outline,
                        label: 'Info',
                        onTap: onInfoTap,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildNavAction(String title) {
    return Text(
      title,
      style: StreamTypography.topNavAction,
    );
  }

  static Widget _buildHeroIconButton({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
