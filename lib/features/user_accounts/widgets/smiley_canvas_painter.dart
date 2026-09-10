import 'package:flutter/material.dart';

class SmileyCanvasPainter extends CustomPainter {
  const SmileyCanvasPainter({this.color = Colors.white});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final eyePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final mouthPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.065
      ..strokeCap = StrokeCap.round;

    final eyeRadius = size.width * 0.06;

    // Left eye
    canvas.drawCircle(
      Offset(size.width * 0.28, size.height * 0.36),
      eyeRadius,
      eyePaint,
    );

    // Right eye
    canvas.drawCircle(
      Offset(size.width * 0.74, size.height * 0.36),
      eyeRadius,
      eyePaint,
    );

    // Mouth arc with bezier curve
    final path = Path()
      ..moveTo(size.width * 0.32, size.height * 0.64)
      ..quadraticBezierTo(
        size.width * 0.52,
        size.height * 0.76,
        size.width * 0.76,
        size.height * 0.58,
      );

    canvas.drawPath(path, mouthPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
