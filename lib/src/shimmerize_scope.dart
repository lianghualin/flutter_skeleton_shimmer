import 'package:flutter/material.dart';

class BoneRect {
  final GlobalKey key;
  final double? borderRadius;
  final bool isCircle;

  const BoneRect({
    required this.key,
    this.borderRadius,
    this.isCircle = false,
  });
}

class ShimmerizeScope extends InheritedWidget {
  final bool enabled;
  final void Function(BoneRect boneRect) register;
  final void Function(GlobalKey key) unregister;

  const ShimmerizeScope({
    super.key,
    required this.enabled,
    required this.register,
    required this.unregister,
    required super.child,
  });

  static ShimmerizeScope? of(BuildContext context) {
    return context.getInheritedWidgetOfExactType<ShimmerizeScope>();
  }

  @override
  bool updateShouldNotify(ShimmerizeScope oldWidget) =>
      enabled != oldWidget.enabled;
}
