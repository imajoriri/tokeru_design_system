import 'package:flutter/material.dart';

/// Corner smoothing border
///
/// 例
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
class TokeruSmoothRectangleBorder extends ContinuousRectangleBorder {
  /// 全ての角を[radius]で指定した半径で角を丸くする。
  TokeruSmoothRectangleBorder.circular(double radius)
      : super(borderRadius: BorderRadius.circular(radius * 2.3529));
}
