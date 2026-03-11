import 'package:flutter/material.dart';

@immutable
class ShimmerThemeData {
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;
  final double borderRadius;

  const ShimmerThemeData({
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.duration = const Duration(milliseconds: 1500),
    this.borderRadius = 4.0,
  });

  ShimmerThemeData copyWith({
    Color? baseColor,
    Color? highlightColor,
    Duration? duration,
    double? borderRadius,
  }) {
    return ShimmerThemeData(
      baseColor: baseColor ?? this.baseColor,
      highlightColor: highlightColor ?? this.highlightColor,
      duration: duration ?? this.duration,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ShimmerThemeData &&
        other.baseColor == baseColor &&
        other.highlightColor == highlightColor &&
        other.duration == duration &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => Object.hash(baseColor, highlightColor, duration, borderRadius);
}
