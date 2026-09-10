import 'package:flutter/material.dart';
import 'package:court_click_movie_app/features/discover/domain/media_item.dart';
import 'package:court_click_movie_app/foundation/components/media_thumbnail.dart';
import 'package:court_click_movie_app/foundation/theme/stream_palette.dart';
import 'package:court_click_movie_app/foundation/theme/stream_typography.dart';

class MovieDetailSheet extends StatelessWidget {
  const MovieDetailSheet({
    super.key,
    required this.item,
  });

  final MediaItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: StreamPalette.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: StreamPalette.surfaceVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Backdrop image
          if (item.backdropUrl.isNotEmpty || item.posterUrl.isNotEmpty) ...[
            MediaThumbnail(
              imageUrl: item.backdropUrl.isNotEmpty ? item.backdropUrl : item.posterUrl,
              height: 180,
              width: double.infinity,
              borderRadius: 8,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
          ],
          // Title
          Text(
            item.title,
            style: StreamTypography.titleLarge.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 8),
          // Metadata row (Rating, Date, Genres)
          Row(
            children: [
              if (item.voteAverage > 0) ...[
                const Icon(Icons.star, color: StreamPalette.ratingGreen, size: 16),
                const SizedBox(width: 4),
                Text(
                  item.voteAverage.toStringAsFixed(1),
                  style: StreamTypography.ratingText,
                ),
                const SizedBox(width: 14),
              ],
              if (item.releaseDate != null && item.releaseDate!.isNotEmpty) ...[
                Text(
                  item.releaseDate!.split('-').first,
                  style: StreamTypography.dateNotice,
                ),
                const SizedBox(width: 14),
              ],
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: StreamPalette.surfaceVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Text(
                  'HD',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: StreamPalette.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Action buttons (Play & Download)
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.play_arrow, color: Colors.black, size: 24),
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
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.download, color: Colors.white, size: 20),
              label: const Text(
                'Download',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: StreamPalette.secondaryButtonBg,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Synopsis / Overview
          if (item.overview.isNotEmpty) ...[
            Text(
              item.overview,
              style: StreamTypography.body.copyWith(fontSize: 13, height: 1.4),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
          ],
          // Genres
          Text(
            item.formattedGenres,
            style: StreamTypography.genreTags,
          ),
        ],
      ),
    );
  }
}
