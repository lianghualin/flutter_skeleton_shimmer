import 'package:flutter/rendering.dart';

class LeafRect {
  final Rect rect;
  final bool isCircle;

  const LeafRect({required this.rect, this.isCircle = false});
}

class RenderTreeWalker {
  /// Walks the render tree from [ancestor] and collects rects of leaf
  /// content widgets: RenderParagraph (Text, RichText, Icon), RenderImage,
  /// and RenderClipOval (CircleAvatar).
  ///
  /// Note: SvgPicture (flutter_svg) uses a custom RenderPicture which is
  /// not auto-detected to avoid requiring a flutter_svg dependency. Use
  /// Bone() to mark SVG areas explicitly.
  static List<LeafRect> collectLeafRects(RenderObject ancestor) {
    final results = <LeafRect>[];
    final ancestorOffset = ancestor is RenderBox
        ? ancestor.localToGlobal(Offset.zero)
        : Offset.zero;

    void visit(RenderObject object) {
      // Text and Icon widgets both render as RenderParagraph
      if (object is RenderParagraph) {
        _addRect(object, ancestorOffset, results);
        return;
      }

      if (object is RenderImage) {
        _addRect(object, ancestorOffset, results);
        return;
      }

      // CircleAvatar uses a RenderDecoratedBox with BoxShape.circle
      if (object is RenderDecoratedBox) {
        final decoration = object.decoration;
        if (decoration is BoxDecoration && decoration.shape == BoxShape.circle) {
          _addRect(object, ancestorOffset, results, isCircle: true);
          return;
        }
      }

      // Also handle explicit ClipOval usage → RenderClipOval
      if (object is RenderClipOval) {
        _addRect(object, ancestorOffset, results, isCircle: true);
        return;
      }

      object.visitChildren(visit);
    }

    ancestor.visitChildren(visit);
    return results;
  }

  static void _addRect(
    RenderBox renderBox,
    Offset ancestorOffset,
    List<LeafRect> results, {
    bool isCircle = false,
  }) {
    if (!renderBox.hasSize) return;
    final size = renderBox.size;
    if (size.isEmpty) return;

    final offset = renderBox.localToGlobal(Offset.zero) - ancestorOffset;
    results.add(LeafRect(
      rect: offset & size,
      isCircle: isCircle,
    ));
  }
}
