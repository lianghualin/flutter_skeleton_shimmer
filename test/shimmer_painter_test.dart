// ignore_for_file: implementation_imports
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_skeleton_shimmer/src/shimmer_painter.dart';
import 'package:flutter_skeleton_shimmer/src/render_tree_walker.dart';

void main() {
  group('ShimmerPainter', () {
    test('shouldRepaint returns true when animation value changes', () {
      final painter1 = ShimmerPainter(
        rects: const [LeafRect(rect: Rect.fromLTWH(0, 0, 100, 20))],
        animationValue: 0.0,
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        borderRadius: 4.0,
      );
      final painter2 = ShimmerPainter(
        rects: const [LeafRect(rect: Rect.fromLTWH(0, 0, 100, 20))],
        animationValue: 0.5,
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        borderRadius: 4.0,
      );
      expect(painter1.shouldRepaint(painter2), true);
    });

    test('shouldRepaint returns false when same animation value', () {
      final painter1 = ShimmerPainter(
        rects: const [LeafRect(rect: Rect.fromLTWH(0, 0, 100, 20))],
        animationValue: 0.5,
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        borderRadius: 4.0,
      );
      final painter2 = ShimmerPainter(
        rects: const [LeafRect(rect: Rect.fromLTWH(0, 0, 100, 20))],
        animationValue: 0.5,
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        borderRadius: 4.0,
      );
      expect(painter1.shouldRepaint(painter2), false);
    });

    testWidgets('paints without errors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: const Size(300, 200),
              painter: ShimmerPainter(
                rects: const [
                  LeafRect(rect: Rect.fromLTWH(10, 10, 200, 16)),
                  LeafRect(rect: Rect.fromLTWH(10, 36, 150, 16)),
                  LeafRect(rect: Rect.fromLTWH(10, 62, 40, 40), isCircle: true),
                ],
                animationValue: 0.5,
                baseColor: Color(0xFFE0E0E0),
                highlightColor: Color(0xFFF5F5F5),
                borderRadius: 4.0,
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    });
  });
}
