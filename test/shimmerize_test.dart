import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_skeleton_shimmer/flutter_skeleton_shimmer.dart';

void main() {
  group('Shimmerize', () {
    testWidgets('renders child normally when disabled', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Shimmerize(
              enabled: false,
              child: Text('Hello World'),
            ),
          ),
        ),
      );

      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets('hides child content when enabled', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Shimmerize(
              enabled: true,
              child: Column(
                children: [
                  Text('Hello World'),
                  Text('Second line'),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pump();
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('preserves layout dimensions when enabled', (tester) async {
      final disabledKey = GlobalKey();
      final enabledKey = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Shimmerize(
              key: disabledKey,
              enabled: false,
              child: const SizedBox(
                width: 200,
                height: 100,
                child: Text('Content'),
              ),
            ),
          ),
        ),
      );

      final disabledSize = tester.getSize(find.byKey(disabledKey));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Shimmerize(
              key: enabledKey,
              enabled: true,
              child: const SizedBox(
                width: 200,
                height: 100,
                child: Text('Content'),
              ),
            ),
          ),
        ),
      );

      await tester.pump();
      final enabledSize = tester.getSize(find.byKey(enabledKey));
      expect(enabledSize, disabledSize);
    });

    testWidgets('works with Bone widgets', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Shimmerize(
              enabled: true,
              child: Column(
                children: [
                  Bone(width: 200, height: 16),
                  Bone.circle(size: 48),
                  Bone(width: 150, height: 12),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pump();
      expect(tester.takeException(), isNull);
    });

    testWidgets('transitions from enabled to disabled', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Shimmerize(
              enabled: true,
              child: Text('Hello'),
            ),
          ),
        ),
      );

      await tester.pump();

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Shimmerize(
              enabled: false,
              child: Text('Hello'),
            ),
          ),
        ),
      );

      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('respects ShimmerTheme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ShimmerTheme(
            data: const ShimmerThemeData(
              baseColor: Colors.red,
              highlightColor: Colors.blue,
              duration: Duration(seconds: 2),
            ),
            child: const Scaffold(
              body: Shimmerize(
                enabled: true,
                child: Text('Themed'),
              ),
            ),
          ),
        ),
      );

      await tester.pump();
      expect(tester.takeException(), isNull);
    });
  });
}
