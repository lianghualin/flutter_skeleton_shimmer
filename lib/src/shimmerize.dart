import 'package:flutter/material.dart';
import 'shimmer_theme.dart';
import 'shimmerize_scope.dart';
import 'render_tree_walker.dart';
import 'shimmer_painter.dart';

class Shimmerize extends StatefulWidget {
  final bool enabled;
  final Widget child;

  const Shimmerize({
    super.key,
    required this.enabled,
    required this.child,
  });

  @override
  State<Shimmerize> createState() => _ShimmerizeState();
}

class _ShimmerizeState extends State<Shimmerize>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final GlobalKey _childKey = GlobalKey();
  final Map<GlobalKey, BoneRect> _bones = {};
  List<LeafRect> _leafRects = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addListener(_onAnimationTick);
  }

  void _onAnimationTick() {
    if (mounted) setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.enabled && !_controller.isAnimating) {
      _startShimmer();
    }
  }

  @override
  void didUpdateWidget(Shimmerize oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled && !oldWidget.enabled) {
      _startShimmer();
    } else if (!widget.enabled && oldWidget.enabled) {
      _stopShimmer();
    }
  }

  void _startShimmer() {
    final theme = ShimmerTheme.of(context);
    _controller.duration = theme.duration;
    _controller.repeat();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _collectRects();
    });
  }

  void _stopShimmer() {
    _controller.stop();
    _controller.reset();
    _leafRects = [];
    _bones.clear();
  }

  void _collectRects() {
    if (!widget.enabled) return;
    final renderObject = _childKey.currentContext?.findRenderObject();
    if (renderObject == null) return;

    final autoRects = RenderTreeWalker.collectLeafRects(renderObject);

    final boneRects = <LeafRect>[];
    final ancestorRenderObject =
        _childKey.currentContext!.findRenderObject()! as RenderBox;
    final ancestorOffset = ancestorRenderObject.localToGlobal(Offset.zero);

    for (final bone in _bones.values) {
      final boneRenderObject =
          bone.key.currentContext?.findRenderObject() as RenderBox?;
      if (boneRenderObject == null || !boneRenderObject.hasSize) continue;
      final offset =
          boneRenderObject.localToGlobal(Offset.zero) - ancestorOffset;
      boneRects.add(LeafRect(
        rect: offset & boneRenderObject.size,
        isCircle: bone.isCircle,
      ));
    }

    if (mounted) {
      setState(() {
        _leafRects = [...autoRects, ...boneRects];
      });
    }
  }

  void _registerBone(BoneRect boneRect) {
    _bones[boneRect.key] = boneRect;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _collectRects();
    });
  }

  void _unregisterBone(GlobalKey key) {
    _bones.remove(key);
  }

  @override
  void dispose() {
    _controller.removeListener(_onAnimationTick);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return ShimmerizeScope(
        enabled: false,
        register: _registerBone,
        unregister: _unregisterBone,
        child: widget.child,
      );
    }

    final theme = ShimmerTheme.of(context);

    return ShimmerizeScope(
      enabled: true,
      register: _registerBone,
      unregister: _unregisterBone,
      child: Stack(
        children: [
          Visibility(
            visible: false,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            maintainInteractivity: false,
            child: KeyedSubtree(
              key: _childKey,
              child: widget.child,
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: ShimmerPainter(
                rects: _leafRects,
                animationValue: _controller.value,
                baseColor: theme.baseColor,
                highlightColor: theme.highlightColor,
                borderRadius: theme.borderRadius,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
