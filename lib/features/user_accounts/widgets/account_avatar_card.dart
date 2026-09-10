import 'package:flutter/material.dart';
import '../../../foundation/theme/stream_palette.dart';
import '../../../foundation/theme/stream_typography.dart';
import '../domain/user_account.dart';
import 'smiley_canvas_painter.dart';

class AccountAvatarCard extends StatelessWidget {
  const AccountAvatarCard({
    super.key,
    required this.account,
    this.size = 104.0,
    this.borderRadius = 6.0,
    this.showLabel = true,
    this.onTap,
  });

  final UserAccount account;
  final double size;
  final double borderRadius;
  final bool showLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final avatarBox = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: account.isKids ? null : account.color,
          gradient: account.isKids
              ? const LinearGradient(
                  colors: StreamPalette.kidsGradient,
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                )
              : null,
        ),
        child: account.isKids
            ? Center(
                child: Text(
                  'kids',
                  style: TextStyle(
                    fontSize: size * 0.32,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFFFFEB3B),
                    letterSpacing: -0.5,
                  ),
                ),
              )
            : CustomPaint(
                size: Size(size, size),
                painter: const SmileyCanvasPainter(),
              ),
      ),
    );

    if (!showLabel) {
      return GestureDetector(
        onTap: onTap,
        child: avatarBox,
      );
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          avatarBox,
          const SizedBox(height: 10),
          Text(
            account.name,
            style: StreamTypography.body.copyWith(
              color: StreamPalette.textPrimary,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
