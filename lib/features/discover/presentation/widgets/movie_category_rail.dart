import 'package:flutter/material.dart';
import 'package:court_click_movie_app/features/discover/domain/media_item.dart';
import 'package:court_click_movie_app/foundation/components/media_thumbnail.dart';
import 'package:court_click_movie_app/foundation/theme/stream_palette.dart';

class MovieCategoryRail extends StatelessWidget {
  const MovieCategoryRail({
    super.key,
    required this.title,
    required this.items,
    this.onItemTap,
    this.showRankNumbers = false,
  });

  final String title;
  final List<MediaItem> items;
  final void Function(MediaItem item)? onItemTap;
  final bool showRankNumbers;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        SizedBox(
          height: 154,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () => onItemTap?.call(item),
                child: SizedBox(
                  width: showRankNumbers ? 130 : 104,
                  height: 154,
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        child: MediaThumbnail(
                          imageUrl: item.posterUrl.isNotEmpty
                              ? item.posterUrl
                              : item.backdropUrl,
                          width: 104,
                          height: 154,
                          borderRadius: 4,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (showRankNumbers)
                        Positioned(
                          left: 0,
                          bottom: -8,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 84,
                              fontWeight: FontWeight.w900,
                              color: StreamPalette.background,
                              shadows: const [
                                Shadow(
                                  offset: Offset(-1.5, -1.5),
                                  color: Colors.white,
                                ),
                                Shadow(
                                  offset: Offset(1.5, -1.5),
                                  color: Colors.white,
                                ),
                                Shadow(
                                  offset: Offset(1.5, 1.5),
                                  color: Colors.white,
                                ),
                                Shadow(
                                  offset: Offset(-1.5, 1.5),
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
