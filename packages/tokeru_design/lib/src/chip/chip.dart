import 'package:flutter/material.dart';
import 'package:tokeru_design/tokeru_design.dart';
import 'package:tokeru_haptics/tokeru_haptics.dart';

/// Chip
class TokeruChip extends StatelessWidget {
  const TokeruChip({
    super.key,
    required this.child,
    this.onTap,
    this.selected = false,
    this.enableHaptics = true,
  });

  /// 子要素。
  final Widget child;

  /// タップした時のアクション。
  final VoidCallback? onTap;

  /// 選択されているかどうか
  final bool selected;

  /// Hapticsを有効にするかどうか。
  final bool enableHaptics;

  @override
  Widget build(BuildContext context) {
    const radius = BorderRadius.all(Radius.circular(8));
    return TokeruButton(
      onTap: onTap != null
          ? () {
              if (enableHaptics) {
                TokeruHaptics.rigidMedium();
              }
              onTap!();
            }
          : null,
      style: switch (selected) {
        true => TokeruButtonStyle.primary(context).copyWith(
            shape: TokeruSmoothRectangleBorder(
              borderRadius: radius,
            ),
          ),
        false => TokeruButtonStyle.transparentSurface(context).copyWith(
            shape: TokeruSmoothRectangleBorder(
              side: BorderSide(color: context.tokeruColors.surfaceOutline),
              borderRadius: radius,
            ),
          ),
      },
      child: DefaultTextStyle.merge(
        style: switch (selected) {
          true => context.tokeruTextTheme.labelLarge.copyWith(
              color: context.tokeruColors.onPrimary,
            ),
          false => context.tokeruTextTheme.labelLarge.copyWith(
              color: context.tokeruColors.onSurface,
            ),
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),
          child: child,
        ),
      ),
    );
  }
}
