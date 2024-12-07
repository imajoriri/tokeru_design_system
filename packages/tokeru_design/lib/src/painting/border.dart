import 'package:flutter/material.dart';
import 'package:smooth_corner/smooth_corner.dart';

/// Corner smoothing border
///
/// 例
///
/// ```
/// Container(
///   decoration: ShapeDecoration(
///     shape: TokeruSmoothRectangleBorder.circular(16),
///   ),
/// );
/// ```
///
/// ```dart
/// ShapeDecoration(
///   shape: TokeruSmoothRectangleBorder.circular(_defaultBorderRadius),
/// ),
/// ```
///
/// ```
/// ClipPath(
///   clipper: ShapeBorderClipper(
///     shape: TokeruSmoothRectangleBorder.circular(16),
///   ),
/// ),
/// ```
class TokeruSmoothRectangleBorder extends SmoothRectangleBorder {
  /// 全ての角を[radius]で指定した半径で角を丸くする。
  TokeruSmoothRectangleBorder.circular(double radius)
      : super(borderRadius: BorderRadius.circular(radius), smoothness: 0.6);
}
