import 'package:flutter/material.dart';
import 'package:tokeru_design/src/button/base_button.dart';
import 'package:tokeru_design/src/painting/border.dart';
import 'package:tokeru_haptics/tokeru_haptics.dart';

enum TokeruIconButtonShape {
  /// 丸型
  circle,

  /// 角丸型
  square,
}

/// 小さめのアイコンボタン。
class TokeruIconButton extends StatefulWidget {
  /// アイコンのWidget。
  final Widget icon;

  /// クリック時の処理。
  final void Function()? onTap;

  /// ツールチップ。
  final String? tooltip;

  /// アイコンの色。
  final Color? iconColor;

  /// パディング。
  final EdgeInsets padding;

  /// ボタンのスタイル。
  final TokeruButtonStyle? style;

  /// ボタンのサイズ。
  final Size size;

  /// アイコンのサイズ。
  final double iconSize;

  /// ボタンの形状。
  final TokeruIconButtonShape shape;

  /// Borderの色。
  final Color? borderColor;

  /// Hapticsを有効にするかどうか。
  final bool enableHaptics;

  const TokeruIconButton.large({
    super.key,
    required this.icon,
    this.style,
    this.onTap,
    this.tooltip,
    this.borderColor,
    this.iconColor,
    this.shape = TokeruIconButtonShape.square,
    this.enableHaptics = true,
  })  : iconSize = 28,
        size = const Size(56, 56),
        padding = const EdgeInsets.all(8);

  const TokeruIconButton.medium({
    super.key,
    required this.icon,
    this.style,
    this.onTap,
    this.tooltip,
    this.borderColor,
    this.iconColor,
    this.shape = TokeruIconButtonShape.square,
    this.enableHaptics = true,
  })  : iconSize = 20,
        size = const Size(44, 44),
        padding = const EdgeInsets.all(8);

  const TokeruIconButton.small({
    super.key,
    required this.icon,
    this.style,
    this.onTap,
    this.tooltip,
    this.borderColor,
    this.iconColor,
    this.shape = TokeruIconButtonShape.square,
    this.enableHaptics = true,
  })  : iconSize = 20,
        size = const Size(32, 32),
        padding = const EdgeInsets.all(4);

  @override
  State<TokeruIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<TokeruIconButton> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip ?? '',
      child: SizedBox.fromSize(
        size: widget.size,
        child: TokeruDefaultButtonStyle.merge(
          style: TokeruButtonStyle(
            shape: TokeruSmoothRectangleBorder(
              side: widget.borderColor != null
                  ? BorderSide(color: widget.borderColor!)
                  : BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  widget.shape == TokeruIconButtonShape.circle ? 100 : 8,
                ),
              ),
            ),
          ),
          child: TokeruButton(
            onTap: widget.onTap != null
                ? () {
                    if (widget.enableHaptics) {
                      TokeruHaptics.rigidMedium();
                    }
                    widget.onTap!();
                  }
                : null,
            style: widget.style,
            child: Container(
              padding: widget.padding,
              alignment: Alignment.center,
              child: IconTheme.merge(
                data: IconThemeData(
                  size: widget.iconSize,
                ),
                child: widget.icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
