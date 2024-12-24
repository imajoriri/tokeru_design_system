import 'package:flutter/cupertino.dart';
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
    this.text,
    this.onTap,
    this.skipTraversal = false,
    this.style,
    this.icon,
    this.enableHaptics = true,
  });

  const TokeruTextButton.large({
    super.key,
    this.text,
    this.icon,
    this.onTap,
    this.skipTraversal = false,
    this.style,
    this.enableHaptics = true,
  }) : type = TokeruTextButtonSize.large;

  const TokeruTextButton.medium({
    super.key,
    this.text,
    this.icon,
    this.onTap,
    this.skipTraversal = false,
    this.style,
    this.enableHaptics = true,
  }) : type = TokeruTextButtonSize.medium;

  const TokeruTextButton.small({
    super.key,
    this.text,
    this.icon,
    this.onTap,
    this.skipTraversal = false,
    this.style,
    this.enableHaptics = true,
  }) : type = TokeruTextButtonSize.small;

  final void Function()? onTap;

  final Widget? text;

  /// アイコン。
  final Widget? icon;

  final bool skipTraversal;

  final TokeruTextButtonSize type;

  /// ボタンのスタイル。
  final TokeruButtonStyle? style;

  /// Hapticsを有効にするかどうか。
  final bool enableHaptics;

  double get height => switch (type) {
        TokeruTextButtonSize.small => 32,
        TokeruTextButtonSize.medium => 44,
        TokeruTextButtonSize.large => 56,
      };

  /// ボタンの幅。
  ///
  /// アイコンのみの場合はheightと同じ値を返すことで正方形にする。
  double? get width {
    if (text == null && icon != null) return height;
    return null;
  }

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
      TokeruTextButtonSize.small => context.tokeruTextTheme.labelSmall,
      TokeruTextButtonSize.medium => context.tokeruTextTheme.labelMidium,
      TokeruTextButtonSize.large => context.tokeruTextTheme.labelLarge,
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
            height: height,
            width: width,
            padding: switch (type) {
              TokeruTextButtonSize.small =>
                EdgeInsets.symmetric(horizontal: context.tokeruSpacing.small),
              TokeruTextButtonSize.medium =>
                EdgeInsets.symmetric(horizontal: context.tokeruSpacing.small),
              TokeruTextButtonSize.large =>
                EdgeInsets.symmetric(horizontal: context.tokeruSpacing.medium),
            },
            child: DefaultTextStyle.merge(
              style: textStyle,
              child: IconTheme.merge(
                data: IconThemeData(size: iconSize),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) icon!,
                    if (text != null && icon != null)
                      SizedBox(width: context.tokeruSpacing.smallX),
                    if (text != null) text!,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
