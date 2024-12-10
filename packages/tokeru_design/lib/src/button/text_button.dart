import 'package:flutter/cupertino.dart';
import 'package:tokeru_design/tokeru_design.dart';

enum TokeruTextButtonSize {
  small,
  medium,
}

/// テキストボタン。
class TokeruTextButton extends StatelessWidget {
  const TokeruTextButton.medium({
    super.key,
    required this.onPressed,
    required this.text,
    this.skipTraversal = false,
    this.style,
    this.icon,
  })  : iconSize = 16,
        type = TokeruTextButtonSize.medium;

  const TokeruTextButton.small({
    super.key,
    required this.onPressed,
    required this.text,
    this.skipTraversal = false,
    this.style,
    this.icon,
  })  : iconSize = 16,
        type = TokeruTextButtonSize.small;

  final void Function()? onPressed;

  final Widget text;

  final bool skipTraversal;

  /// アイコンのサイズ。
  final double iconSize;

  /// アイコン。
  final Widget? icon;

  final TokeruTextButtonSize type;

  /// ボタンのスタイル。
  final TokeruButtonStyle? style;

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
          onPressed: onPressed,
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
