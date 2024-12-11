import 'package:flutter/cupertino.dart';
import 'package:tokeru_design/tokeru_design.dart';
import 'package:tokeru_haptics/tokeru_haptics.dart';

enum TokeruTextButtonSize {
  small,
  medium,
}

/// テキストボタン。
class TokeruTextButton extends StatelessWidget {
  const TokeruTextButton.medium({
    super.key,
    required this.text,
    this.onTap,
    this.skipTraversal = false,
    this.style,
    this.icon,
    this.enableHaptics = true,
  })  : iconSize = 16,
        type = TokeruTextButtonSize.medium;

  const TokeruTextButton.small({
    super.key,
    required this.text,
    this.onTap,
    this.skipTraversal = false,
    this.style,
    this.icon,
    this.enableHaptics = true,
  })  : iconSize = 16,
        type = TokeruTextButtonSize.small;

  final void Function()? onTap;

  final Widget text;

  final bool skipTraversal;

  /// アイコンのサイズ。
  final double iconSize;

  /// アイコン。
  final Widget? icon;

  final TokeruTextButtonSize type;

  /// ボタンのスタイル。
  final TokeruButtonStyle? style;

  /// Hapticsを有効にするかどうか。
  final bool enableHaptics;

  @override
  Widget build(BuildContext context) {
    final textStyle = switch (type) {
      TokeruTextButtonSize.small => context.tokeruTextTheme.labelSmall,
      TokeruTextButtonSize.medium => context.tokeruTextTheme.labelMidium,
    };
    final shape = switch (type) {
      TokeruTextButtonSize.small => TokeruSmoothRectangleBorder.circular(8),
      TokeruTextButtonSize.medium => TokeruSmoothRectangleBorder.circular(12),
    };

    return Container(
      height: switch (type) {
        TokeruTextButtonSize.small => 32,
        TokeruTextButtonSize.medium => 40,
      },
      alignment: Alignment.center,
      child: TokeruDefaultButtonStyle.merge(
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
          child: Padding(
            padding: switch (type) {
              TokeruTextButtonSize.small => EdgeInsets.symmetric(
                  vertical: context.tokeruSpacing.smallX,
                  horizontal: context.tokeruSpacing.small,
                ),
              TokeruTextButtonSize.medium =>
                EdgeInsets.all(context.tokeruSpacing.small),
            },
            child: DefaultTextStyle.merge(
              style: textStyle,
              child: IconTheme.merge(
                data: IconThemeData(
                  size: iconSize,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      icon!,
                      SizedBox(width: context.tokeruSpacing.smallX),
                    ],
                    text,
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
