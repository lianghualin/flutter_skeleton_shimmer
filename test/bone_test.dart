import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_skeleton_shimmer/flutter_skeleton_shimmer.dart';

void main() {
  group('Bone', () {
    testWidgets('renders as SizedBox with given dimensions when no Shimmerize ancestor',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Bone(width: 100, height: 20),
          ),
        ),
      );

      // Should render as an empty SizedBox when not inside Shimmerize
      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).last);
      expect(sizedBox.width, 100);
      expect(sizedBox.height, 20);
    });

    testWidgets('Bone.circle creates a circle bone', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Bone.circle(size: 48),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).last);
      expect(sizedBox.width, 48);
      expect(sizedBox.height, 48);
    });

    testWidgets('renders child when provided and not loading', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Bone(
              width: 100,
              height: 20,
              child: Text('Hello'),
            ),
          ),
        ),
      );

      expect(find.text('Hello'), findsOneWidget);
    });
  });
}
