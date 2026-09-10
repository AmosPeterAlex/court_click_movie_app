import 'package:flutter/material.dart';
import 'package:court_click_movie_app/features/discover/domain/media_item.dart';
import 'package:court_click_movie_app/foundation/components/media_thumbnail.dart';
import 'package:court_click_movie_app/foundation/theme/stream_palette.dart';
import 'package:court_click_movie_app/foundation/theme/stream_typography.dart';

class UpcomingMovieCard extends StatefulWidget {
  const UpcomingMovieCard({
    super.key,
    required this.item,
    this.onTap,
  });

  final MediaItem item;
  final VoidCallback? onTap;

  @override
  State<UpcomingMovieCard> createState() => _UpcomingMovieCardState();
}

class _UpcomingMovieCardState extends State<UpcomingMovieCard> {
  bool _isReminded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Wide Backdrop Image (200px height)
            MediaThumbnail(
              imageUrl: widget.item.backdropUrl.isNotEmpty
                  ? widget.item.backdropUrl
                  : widget.item.posterUrl,
              height: 200,
              width: double.infinity,
              borderRadius: 0,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 12),

            // Action Buttons Row (Remind Me & Share)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildActionBtn(
                    icon: _isReminded
                        ? Icons.notifications_active_rounded
                        : Icons.notifications_none_rounded,
                    label: _isReminded ? 'Reminded' : 'Remind Me',
                    color: _isReminded ? StreamPalette.primary : Colors.white,
                    onTap: () {
                      setState(() => _isReminded = !_isReminded);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            _isReminded
                                ? "We'll remind you when ${widget.item.title} is released!"
                                : 'Reminder removed',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 32),
                  _buildActionBtn(
                    icon: Icons.share_rounded,
                    label: 'Share',
                    color: Colors.white,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sharing ${widget.item.title}...'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Content text details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Premiere date subtitle
                  Text(
                    widget.item.formattedPremiereDate,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: StreamPalette.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Title
                  Text(
                    widget.item.title,
                    style: StreamTypography.titleLarge.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  // Synopsis / overview
                  if (widget.item.overview.isNotEmpty)
                    Text(
                      widget.item.overview,
                      style: StreamTypography.bodySmall.copyWith(
                        color: StreamPalette.textSecondary,
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 8),
                  // Bullet separated genres
                  Text(
                    widget.item.formattedGenres,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildActionBtn({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
