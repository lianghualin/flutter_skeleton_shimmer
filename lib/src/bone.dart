import 'package:flutter/material.dart';
import 'shimmerize_scope.dart';

class Bone extends StatefulWidget {
  final double? width;
  final double? height;
  final double? borderRadius;
  final bool isCircle;
  final Widget? child;

  const Bone({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.isCircle = false,
    this.child,
  });

  const Bone.circle({
    super.key,
    required double size,
    this.child,
  })  : width = size,
        height = size,
        borderRadius = null,
        isCircle = true;

  @override
  State<Bone> createState() => _BoneState();
}

class _BoneState extends State<Bone> {
  final GlobalKey _boneKey = GlobalKey();
  ShimmerizeScope? _scope;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scope = ShimmerizeScope.of(context);
    if (_scope != null && _scope!.enabled) {
      _scope!.register(BoneRect(
        key: _boneKey,
        borderRadius: widget.borderRadius,
        isCircle: widget.isCircle,
      ));
    }
  }

  @override
  void deactivate() {
    _scope?.unregister(_boneKey);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _boneKey,
      width: widget.width,
      height: widget.height,
      child: widget.child,
    );
  }
}
