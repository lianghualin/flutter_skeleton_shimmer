// ignore_for_file: implementation_imports
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_skeleton_shimmer/src/render_tree_walker.dart';

void main() {
  group('RenderTreeWalker', () {
    testWidgets('finds Text render objects', (tester) async {
      final ancestorKey = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RepaintBoundary(
              key: ancestorKey,
              child: const Column(
                children: [
                  Text('Hello'),
                  Text('World'),
                ],
              ),
            ),
          ),
        ),
      );

      final ancestor = ancestorKey.currentContext!.findRenderObject()!;
      final rects = RenderTreeWalker.collectLeafRects(ancestor);
      expect(rects.length, 2);
    });

    testWidgets('finds Icon render objects', (tester) async {
      final ancestorKey = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: IconTheme(
              data: const IconThemeData(size: 24),
              child: RepaintBoundary(
                key: ancestorKey,
                child: const Row(
                  children: [
                    Icon(Icons.home),
                    Icon(Icons.settings),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      final ancestor = ancestorKey.currentContext!.findRenderObject()!;
      final rects = RenderTreeWalker.collectLeafRects(ancestor);
      // Icons render as RenderParagraph (RichText with icon font character)
      expect(rects.length, 2);
    });

    testWidgets('finds CircleAvatar as circle', (tester) async {
      final ancestorKey = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RepaintBoundary(
              key: ancestorKey,
              child: const CircleAvatar(
                radius: 24,
                child: Text('A'),
              ),
            ),
          ),
        ),
      );

      final ancestor = ancestorKey.currentContext!.findRenderObject()!;
      final rects = RenderTreeWalker.collectLeafRects(ancestor);
      // Should find the CircleAvatar's ClipOval as a circle rect
      expect(rects.any((r) => r.isCircle), true);
    });

    testWidgets('does not detect plain Container', (tester) async {
      final ancestorKey = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RepaintBoundary(
              key: ancestorKey,
              child: Column(
                children: [
                  Container(width: 100, height: 100, color: Colors.red),
                ],
              ),
            ),
          ),
        ),
      );

      // Container with color becomes a RenderDecoratedBox — not a leaf target.
      final ancestor = ancestorKey.currentContext!.findRenderObject()!;
      final rects = RenderTreeWalker.collectLeafRects(ancestor);
      expect(rects.length, 0);
    });
  });
}
