import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/stream_palette.dart';

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: StreamPalette.shimmerBase,
      highlightColor: StreamPalette.shimmerHighlight,
      child: child,
    );
  }

  static Widget box({
    double? width,
    double? height,
    double borderRadius = 4,
  }) {
    return SkeletonLoader(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: StreamPalette.shimmerBase,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  static Widget circle({double size = 48}) {
    return SkeletonLoader(
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: StreamPalette.shimmerBase,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  static Widget heroBannerPlaceholder() {
    return SkeletonLoader(
      child: Container(
        height: 480,
        width: double.infinity,
        color: StreamPalette.shimmerBase,
      ),
    );
  }

  static Widget categoryRailPlaceholder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: box(width: 140, height: 18),
        ),
        SizedBox(
          height: 154,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (_, _) => box(width: 104, height: 154, borderRadius: 4),
          ),
        ),
      ],
    );
  }

  static Widget tileRowPlaceholder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SkeletonLoader(
        child: Container(
          height: 76,
          decoration: BoxDecoration(
            color: StreamPalette.shimmerBase,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
