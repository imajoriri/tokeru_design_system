import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokeru_design/tokeru_design.dart';
import 'package:tokeru_haptics/tokeru_haptics.dart';

enum TokeruTextButtonSize {
  small,
  medium,
  large,
}

/// テキストボタン。
class TokeruTextButton extends StatelessWidget {
  const TokeruTextButton({
    super.key,
    required this.type,
    required this.child,
    this.onTap,
    this.skipTraversal = false,
    this.style,
    this.enableHaptics = true,
  });

  const TokeruTextButton.large({
    super.key,
    required this.child,
    this.onTap,
    this.skipTraversal = false,
    this.style,
    this.enableHaptics = true,
  }) : type = TokeruTextButtonSize.large;

  const TokeruTextButton.medium({
    super.key,
    required this.child,
    this.onTap,
    this.skipTraversal = false,
    this.style,
    this.enableHaptics = true,
  }) : type = TokeruTextButtonSize.medium;

  const TokeruTextButton.small({
    super.key,
    required this.child,
    this.onTap,
    this.skipTraversal = false,
    this.style,
    this.enableHaptics = true,
  }) : type = TokeruTextButtonSize.small;

  final void Function()? onTap;

  /// Text or Icon.
  final Widget child;

  final bool skipTraversal;

  final TokeruTextButtonSize type;

  /// ボタンのスタイル。
  final TokeruButtonStyle? style;

  /// Hapticsを有効にするかどうか。
  final bool enableHaptics;

  double get size => switch (type) {
        TokeruTextButtonSize.small => 32,
        TokeruTextButtonSize.medium => 44,
        TokeruTextButtonSize.large => 56,
      };

  double get iconSize => switch (type) {
        TokeruTextButtonSize.small => 16.0,
        TokeruTextButtonSize.medium => 20.0,
        TokeruTextButtonSize.large => 24.0,
      };

  TokeruSmoothRectangleBorder get shape => switch (type) {
        TokeruTextButtonSize.small => TokeruSmoothRectangleBorder.circular(8),
        TokeruTextButtonSize.medium => TokeruSmoothRectangleBorder.circular(12),
        TokeruTextButtonSize.large => TokeruSmoothRectangleBorder.circular(12),
      };

  @override
  Widget build(BuildContext context) {
    final textStyle = switch (type) {
      TokeruTextButtonSize.small => context.tokeruTextTheme.labelMidium,
      TokeruTextButtonSize.medium => context.tokeruTextTheme.labelLarge,
      TokeruTextButtonSize.large => context.tokeruTextTheme.bodyLarge,
    };

    return TokeruDefaultButtonStyle.merge(
      style: TokeruButtonStyle(shape: shape),
      child: TokeruButton(
        onTap: onTap != null
            ? () {
                if (enableHaptics) {
                  TokeruHaptics.rigidMedium();
                }
                onTap!();
              }
            : null,
        skipTraversal: skipTraversal,
        style: style,
        child: AnimatedSize(
          duration: tokeruDurationNormal,
          curve: TokeruCurves.easeOutDefault,
          child: Container(
            constraints: BoxConstraints(minWidth: size, minHeight: size),
            padding: switch (type) {
              TokeruTextButtonSize.small =>
                EdgeInsets.symmetric(horizontal: context.tokeruSpacing.medium),
              TokeruTextButtonSize.medium =>
                EdgeInsets.symmetric(horizontal: context.tokeruSpacing.medium),
              TokeruTextButtonSize.large =>
                EdgeInsets.symmetric(horizontal: context.tokeruSpacing.medium),
            },
            alignment: Alignment.center,
            child: DefaultTextStyle.merge(
              style: textStyle,
              child: IconTheme.merge(
                data: IconThemeData(size: iconSize),
                child: SizedBox(
                  width: double.infinity,
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
