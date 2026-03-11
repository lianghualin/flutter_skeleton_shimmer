import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_skeleton_shimmer/flutter_skeleton_shimmer.dart';

void main() {
  group('ShimmerThemeData', () {
    test('has sensible defaults', () {
      const data = ShimmerThemeData();
      expect(data.baseColor, const Color(0xFFE0E0E0));
      expect(data.highlightColor, const Color(0xFFF5F5F5));
      expect(data.duration, const Duration(milliseconds: 1500));
      expect(data.borderRadius, 4.0);
    });

    test('supports custom values', () {
      const data = ShimmerThemeData(
        baseColor: Colors.red,
        highlightColor: Colors.blue,
        duration: Duration(seconds: 2),
        borderRadius: 8.0,
      );
      expect(data.baseColor, Colors.red);
      expect(data.highlightColor, Colors.blue);
      expect(data.duration, const Duration(seconds: 2));
      expect(data.borderRadius, 8.0);
    });

    test('copyWith works', () {
      const data = ShimmerThemeData();
      final modified = data.copyWith(baseColor: Colors.red);
      expect(modified.baseColor, Colors.red);
      expect(modified.highlightColor, const Color(0xFFF5F5F5));
    });
  });

  group('ShimmerTheme', () {
    testWidgets('provides theme data to descendants', (tester) async {
      const themeData = ShimmerThemeData(baseColor: Colors.red);
      ShimmerThemeData? received;

      await tester.pumpWidget(
        MaterialApp(
          home: ShimmerTheme(
            data: themeData,
            child: Builder(
              builder: (context) {
                received = ShimmerTheme.of(context);
                return const SizedBox();
              },
            ),
          ),
        ),
      );

      expect(received, isNotNull);
      expect(received!.baseColor, Colors.red);
    });

    testWidgets('returns default when no ShimmerTheme ancestor', (tester) async {
      ShimmerThemeData? received;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              received = ShimmerTheme.of(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(received, const ShimmerThemeData());
    });
  });
}
