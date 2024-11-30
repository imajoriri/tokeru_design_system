import 'package:flutter/material.dart';
import 'package:tokeru_design/tokeru_design.dart';

extension _ButtonStatusColor on Color {
  /// ホバー時のカラーを返すメソッド。
  Color get hovered => withOpacity(0.08);

  /// フォーカス時のカラーを返すメソッド。
  Color get focused => withOpacity(0.10);

  /// プレス時のカラーを返すメソッド。
  Color get pressed => withOpacity(0.10);

  /// Disabledのカラーを返すメソッド。
  Color get disabled => withOpacity(0.38);
}

class TokeruButtonStyle {
  /// ボタンのコンテンツ(中身)のカラー。
  ///
  /// [IconTheme]、[DefaultTextStyle]を使用してコンテンツのカラーとして使用される。
  /// ホバーやフォーカス時のカラーは、このカラーを元に計算される。
  final Color? contentColor;

  /// ボタンの背景色。
  final Color? backgroundColor;

  /// ボタンを押した時などのステート変更時にアニメーションするかどうか。
  final bool stateColorAnimated;

  /// [backgroundColor]が変更時にアニメーションするかどうか。
  final bool backgroundColorAnimated;

  /// ボタンの形状。
  final ShapeBorder? shape;

  const TokeruButtonStyle({
    this.contentColor,
    this.backgroundColor,
    this.stateColorAnimated = true,
    this.backgroundColorAnimated = true,
    this.shape,
  });

  TokeruButtonStyle merge(TokeruButtonStyle? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      contentColor: other.contentColor,
      backgroundColor: other.backgroundColor,
      stateColorAnimated: other.stateColorAnimated,
      backgroundColorAnimated: other.backgroundColorAnimated,
      shape: other.shape,
    );
  }

  TokeruButtonStyle copyWith({
    Color? contentColor,
    Color? backgroundColor,
    Color? hoveredColor,
    Color? focusedColor,
    Color? pressedColor,
    Color? disabledColor,
    bool? stateColorAnimated,
    bool? backgroundColorAnimated,
    ShapeBorder? shape,
  }) =>
      TokeruButtonStyle(
        contentColor: contentColor ?? this.contentColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        stateColorAnimated: stateColorAnimated ?? this.stateColorAnimated,
        backgroundColorAnimated:
            backgroundColorAnimated ?? this.backgroundColorAnimated,
        shape: shape ?? this.shape,
      );

  /// defaultなボタンのスタイル。
  static TokeruButtonStyle defaultStyle(BuildContext context) =>
      TokeruButtonStyle(
        contentColor: context.tokeruColors.onPrimary,
        backgroundColor: context.tokeruColors.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      );

  /// Primaryなボタンのスタイル。
  static TokeruButtonStyle primary(BuildContext context) => TokeruButtonStyle(
        contentColor: context.tokeruColors.onPrimary,
        backgroundColor: context.tokeruColors.primary,
      );

  /// Secondaryなボタンのスタイル。
  static TokeruButtonStyle secondary(BuildContext context) => TokeruButtonStyle(
        contentColor: context.tokeruColors.onSecondary,
        backgroundColor: context.tokeruColors.secondary,
      );
}

class TokeruDefaultIconButtonStyle extends InheritedTheme {
  final TokeruButtonStyle style;
  const TokeruDefaultIconButtonStyle({
    super.key,
    required this.style,
    required super.child,
  });

  /// 親の[TokeruDefaultIconButtonStyle]を取得する。
  ///
  /// 取得できない場合は、[TokeruButtonStyle.primary]を使用した[TokeruDefaultIconButtonStyle]を返す。
  static TokeruDefaultIconButtonStyle of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
            TokeruDefaultIconButtonStyle>() ??
        TokeruDefaultIconButtonStyle(
          style: TokeruButtonStyle.defaultStyle(context),
          child: const SizedBox.shrink(),
        );
  }

  static Widget merge({
    required Widget child,
    TokeruButtonStyle? style,
  }) {
    return Builder(builder: (context) {
      final currentStyle = TokeruDefaultIconButtonStyle.of(context).style;
      return TokeruDefaultIconButtonStyle(
        style: currentStyle.merge(style),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(TokeruDefaultIconButtonStyle oldWidget) {
    return style != oldWidget.style;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return TokeruDefaultIconButtonStyle(
      style: style,
      child: child,
    );
  }
}

/// ボタンとしての基本的な機能を持つWidget
///
/// - Hovered, Focused, Pressedの状態に応じて、カラーを変更する。
/// - Pressed状態の時にbounceする。([bounce]がtrueの時)
class TokeruButton extends StatefulWidget {
  const TokeruButton({
    super.key,
    required this.child,
    this.style,
    this.onPressed,
    this.onLongPress,
    this.skipTraversal = false,
  }) : bounce = onLongPress != null;

  final Widget child;

  final TokeruButtonStyle? style;

  /// ボタンが押された時のコールバック。
  final void Function()? onPressed;

  final void Function()? onLongPress;

  /// Pressed状態の時にbounceするかどうか。
  ///
  /// バウンスすることで長押し可能であることを示唆したいため、[onLongPress]がnullの場合はbounceしない。
  final bool bounce;

  final bool skipTraversal;

  @override
  State<TokeruButton> createState() => _TokeruButtonState();
}

class _TokeruButtonState extends State<TokeruButton> {
  bool get enabled => widget.onPressed != null;

  bool hover = false;
  bool focus = false;
  bool pressed = false;

  void onInvoke() {
    if (widget.onPressed == null) {
      return;
    }
    if (!pressed) {
      setState(() {
        pressed = true;
      });
    }
    widget.onPressed?.call();
    if (context.mounted) {
      setState(() {
        pressed = false;
      });
    }
    return;
  }

  Color get overlayColor {
    final defaultStyle = TokeruDefaultIconButtonStyle.of(context).style;
    late final Color overlayColor;
    if (!enabled) {
      overlayColor = widget.style?.contentColor?.disabled ??
          defaultStyle.contentColor?.disabled ??
          Colors.transparent;
    } else if (pressed) {
      overlayColor = widget.style?.contentColor?.pressed ??
          defaultStyle.contentColor?.pressed ??
          Colors.transparent;
    } else if (hover) {
      overlayColor = widget.style?.contentColor?.hovered ??
          defaultStyle.contentColor?.hovered ??
          Colors.transparent;
    } else if (focus) {
      overlayColor = widget.style?.contentColor?.focused ??
          defaultStyle.contentColor?.focused ??
          Colors.transparent;
    } else {
      overlayColor =
          widget.style?.backgroundColor?.withOpacity(0) ?? Colors.transparent;
    }
    return overlayColor;
  }

  @override
  Widget build(BuildContext context) {
    final style = TokeruDefaultIconButtonStyle.of(context).style;
    final backgroundColorAnimated =
        widget.style?.backgroundColorAnimated ?? style.backgroundColorAnimated;
    final stateColorAnimated =
        widget.style?.stateColorAnimated ?? style.stateColorAnimated;
    final backgroundColor =
        widget.style?.backgroundColor ?? style.backgroundColor;
    final shape = widget.style?.shape ?? style.shape!;
    final contentColor = widget.style?.contentColor ?? style.contentColor;

    final backgroundColorDuration =
        Duration(milliseconds: backgroundColorAnimated ? 10 : 0);
    final stateColorduration =
        Duration(milliseconds: stateColorAnimated ? 100 : 0);

    // ボタンのbounceアニメーション時間。
    const bounceDuration = Duration(milliseconds: 200);

    return Semantics(
      container: true,
      child: FocusableActionDetector(
        focusNode: FocusNode(skipTraversal: widget.skipTraversal || !enabled),
        onShowHoverHighlight: (value) => setState(() {
          hover = value;
        }),
        onShowFocusHighlight: (value) => setState(() {
          focus = value;
        }),
        mouseCursor:
            enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        actions: <Type, Action<Intent>>{
          ActivateIntent:
              CallbackAction<ActivateIntent>(onInvoke: (_) => onInvoke()),
          ButtonActivateIntent: CallbackAction<ButtonActivateIntent>(
            onInvoke: (_) => onInvoke(),
          ),
        },
        child: GestureDetector(
          onTap: onInvoke,
          onTapDown: (detail) => setState(() {
            pressed = true;
          }),
          onTapCancel: () => setState(() {
            pressed = false;
          }),
          onLongPress: widget.onLongPress,
          child: AnimatedScale(
            duration: bounceDuration,
            curve: Curves.easeOutExpo,
            scale: pressed && enabled && widget.bounce ? 0.95 : 1.0,
            child: Stack(
              children: [
                // Container layer
                Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedContainer(
                    duration: backgroundColorDuration,
                    decoration: ShapeDecoration(
                      color: backgroundColor,
                      shape: shape,
                    ),
                  ),
                ),

                // State layer
                Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedContainer(
                    duration: stateColorduration,
                    decoration:
                        ShapeDecoration(color: overlayColor, shape: shape),
                  ),
                ),

                // Content layer
                IconTheme.merge(
                  data: IconThemeData(
                    color: contentColor,
                  ),
                  child: DefaultTextStyle.merge(
                    style: TextStyle(
                      color: contentColor,
                    ),
                    child: widget.child,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
