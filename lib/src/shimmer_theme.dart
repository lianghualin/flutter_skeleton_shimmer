import 'package:flutter/material.dart';
import 'shimmer_theme_data.dart';

class ShimmerTheme extends InheritedWidget {
  final ShimmerThemeData data;

  const ShimmerTheme({
    super.key,
    required this.data,
    required super.child,
  });

  static ShimmerThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<ShimmerTheme>();
    return theme?.data ?? const ShimmerThemeData();
  }

  @override
  bool updateShouldNotify(ShimmerTheme oldWidget) => data != oldWidget.data;
}
