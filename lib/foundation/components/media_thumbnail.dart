import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../theme/stream_palette.dart';
import 'skeleton_loader.dart';

class MediaThumbnail extends StatelessWidget {
  const MediaThumbnail({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 4.0,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final clipRadius = BorderRadius.circular(borderRadius);

    if (imageUrl.isEmpty) {
      return ClipRRect(
        borderRadius: clipRadius,
        child: Container(
          width: width,
          height: height,
          color: StreamPalette.surfaceElevated,
          child: const Center(
            child: Icon(
              Icons.movie_creation_outlined,
              color: StreamPalette.textHint,
              size: 28,
            ),
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: clipRadius,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => SkeletonLoader.box(
          width: width,
          height: height,
          borderRadius: borderRadius,
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          color: StreamPalette.surfaceElevated,
          child: const Center(
            child: Icon(
              Icons.broken_image_outlined,
              color: StreamPalette.textHint,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
