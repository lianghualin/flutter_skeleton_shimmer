import 'package:flutter/material.dart';
import 'render_tree_walker.dart';

class ShimmerPainter extends CustomPainter {
  final List<LeafRect> rects;
  final double animationValue;
  final Color baseColor;
  final Color highlightColor;
  final double borderRadius;

  ShimmerPainter({
    required this.rects,
    required this.animationValue,
    required this.baseColor,
    required this.highlightColor,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (rects.isEmpty) return;

    final shimmerWidth = size.width * 0.4;
    final dx = -shimmerWidth + (size.width + shimmerWidth * 2) * animationValue;

    final gradient = LinearGradient(
      colors: [baseColor, highlightColor, baseColor],
      stops: const [0.0, 0.5, 1.0],
    );

    final shaderRect = Rect.fromLTWH(dx, 0, shimmerWidth, size.height);
    final paint = Paint()
      ..shader = gradient.createShader(shaderRect);

    for (final leafRect in rects) {
      final rect = leafRect.rect;
      if (leafRect.isCircle) {
        final radius = rect.shortestSide / 2;
        canvas.drawCircle(rect.center, radius, Paint()..color = baseColor);
        canvas.drawCircle(rect.center, radius, paint);
      } else {
        final rrect = RRect.fromRectAndRadius(
          rect,
          Radius.circular(borderRadius),
        );
        canvas.drawRRect(rrect, Paint()..color = baseColor);
        canvas.drawRRect(rrect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(ShimmerPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue ||
        rects.length != oldDelegate.rects.length ||
        baseColor != oldDelegate.baseColor ||
        highlightColor != oldDelegate.highlightColor;
  }
}
