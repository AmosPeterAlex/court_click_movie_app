import 'package:flutter/material.dart';
import 'package:court_click_movie_app/features/discover/domain/media_item.dart';
import 'package:court_click_movie_app/foundation/components/media_thumbnail.dart';
import 'package:court_click_movie_app/foundation/theme/stream_palette.dart';
import 'package:court_click_movie_app/foundation/theme/stream_typography.dart';

class NotificationItemRow extends StatelessWidget {
  const NotificationItemRow({
    super.key,
    required this.item,
    this.onTap,
  });

  final MediaItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      color: StreamPalette.notificationBg,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              MediaThumbnail(
                imageUrl: item.backdropUrl.isNotEmpty ? item.backdropUrl : item.posterUrl,
                width: 90,
                height: 52,
                borderRadius: 3,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'New Arrival',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: StreamPalette.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.title,
                      style: StreamTypography.bodySmall.copyWith(
                        color: StreamPalette.textSecondary,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.releaseDate ?? 'Coming Soon',
                      style: const TextStyle(
                        fontSize: 11,
                        color: StreamPalette.textHint,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
