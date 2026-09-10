import 'package:flutter/material.dart';
import 'package:court_click_movie_app/features/discover/domain/media_item.dart';
import 'package:court_click_movie_app/foundation/components/media_thumbnail.dart';
import 'package:court_click_movie_app/foundation/theme/stream_palette.dart';
import 'package:court_click_movie_app/foundation/theme/stream_typography.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({
    super.key,
    required this.item,
    this.onTap,
    this.isTop10 = false,
  });

  final MediaItem item;
  final VoidCallback? onTap;
  final bool isTop10;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      margin: const EdgeInsets.only(bottom: 3),
      color: StreamPalette.searchTileBg,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            // Thumbnail with optional TOP 10 badge
            Stack(
              children: [
                MediaThumbnail(
                  imageUrl: item.backdropUrl.isNotEmpty ? item.backdropUrl : item.posterUrl,
                  width: 120,
                  height: 76,
                  fit: BoxFit.cover,
                  borderRadius: 0,
                ),
                if (isTop10)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: StreamPalette.primary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: const Text(
                        'TOP\n10',
                        style: TextStyle(
                          fontSize: 6,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 0.9,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            // Title
            Expanded(
              child: Text(
                item.title,
                style: StreamTypography.tileTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            // Play circle outline icon
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.play_circle_outline_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
