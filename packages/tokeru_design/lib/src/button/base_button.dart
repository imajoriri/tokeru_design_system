import 'package:flutter/material.dart';
import 'package:tokeru_design/tokeru_design.dart';

extension _ButtonStatusColor on Color {
  /// ホバー時のカラーを返すメソッド。
  Color get hovered => withValues(alpha: 0.08);

  /// フォーカス時のカラーを返すメソッド。
  Color get focused => withValues(alpha: 0.10);

  /// プレス時のカラーを返すメソッド。
  Color get pressed => withValues(alpha: 0.10);

  /// Disabledのカラーを返すメソッド。
  Color get disabled => withValues(alpha: 0.38);
}

class TokeruButtonStyle {
  /// ボタンのコンテンツ(中身)のカラー。
  ///
  /// [IconTheme]、[DefaultTextStyle]を使用してコンテンツのカラーとして使用される。
  /// ホバーやフォーカス時のカラーは、このカラーを元に計算される。
  final Color? contentColor;

  /// ボタンの背景色。
  final Color? backgroundColor;

  /// [backgroundColor]が変更時にアニメーションするかどうか。
  final bool backgroundColorAnimated;

  /// ボタンの形状。
  final ShapeBorder? shape;

  /// ボタンの影。
  final List<BoxShadow>? shadows;

  const TokeruButtonStyle({
    this.contentColor,
    this.backgroundColor,
    this.backgroundColorAnimated = true,
    this.shape,
    this.shadows,
  });

  TokeruButtonStyle merge(TokeruButtonStyle? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      contentColor: other.contentColor,
      backgroundColor: other.backgroundColor,
      backgroundColorAnimated: other.backgroundColorAnimated,
      shape: other.shape,
      shadows: other.shadows,
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
    List<BoxShadow>? shadows,
  }) =>
      TokeruButtonStyle(
        contentColor: contentColor ?? this.contentColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        backgroundColorAnimated:
            backgroundColorAnimated ?? this.backgroundColorAnimated,
        shape: shape ?? this.shape,
        shadows: shadows ?? this.shadows,
      );

  /// defaultなボタンのスタイル。
  static TokeruButtonStyle defaultStyle(BuildContext context) =>
      TokeruButtonStyle(
        contentColor: context.tokeruColors.onPrimary,
        backgroundColor: context.tokeruColors.primary,
        shape: TokeruSmoothRectangleBorder.circular(8),
      );

  /// Primaryなボタンのスタイル。
  static TokeruButtonStyle primary(BuildContext context) => TokeruButtonStyle(
        contentColor: context.tokeruColors.onPrimary,
        backgroundColor: context.tokeruColors.primary,
      );

  /// 背景色が透明のボタンのスタイル。
  static TokeruButtonStyle transparentSurface(BuildContext context) =>
      TokeruButtonStyle(
        contentColor: context.tokeruColors.onSurface,
        backgroundColor: context.tokeruColors.surface,
      );

  /// 背景色が透明のボタンのスタイル。
  static TokeruButtonStyle transparentBackground(BuildContext context) =>
      TokeruButtonStyle(
        contentColor: context.tokeruColors.onBackground,
        backgroundColor: context.tokeruColors.background,
      );
}

class TokeruDefaultButtonStyle extends InheritedTheme {
  final TokeruButtonStyle style;
  const TokeruDefaultButtonStyle({
    super.key,
    required this.style,
    required super.child,
  });

  /// 親の[TokeruDefaultIconButtonStyle]を取得する。
  ///
  /// 取得できない場合は、[TokeruButtonStyle.primary]を使用した[TokeruDefaultIconButtonStyle]を返す。
  static TokeruDefaultButtonStyle of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<TokeruDefaultButtonStyle>() ??
        TokeruDefaultButtonStyle(
          style: TokeruButtonStyle.defaultStyle(context),
          child: const SizedBox.shrink(),
        );
  }

  static Widget merge({
    required Widget child,
    TokeruButtonStyle? style,
  }) {
    return Builder(builder: (context) {
      final currentStyle = TokeruDefaultButtonStyle.of(context).style;
      return TokeruDefaultButtonStyle(
        style: currentStyle.merge(style),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(TokeruDefaultButtonStyle oldWidget) {
    return style != oldWidget.style;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return TokeruDefaultButtonStyle(
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
    final defaultStyle = TokeruDefaultButtonStyle.of(context).style;
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
      overlayColor = widget.style?.backgroundColor?.withValues(alpha: 0) ??
          Colors.transparent;
    }
    return overlayColor;
  }

  @override
  Widget build(BuildContext context) {
    final style = TokeruDefaultButtonStyle.of(context).style;
    final backgroundColorAnimated =
        widget.style?.backgroundColorAnimated ?? style.backgroundColorAnimated;
    final backgroundColor =
        widget.style?.backgroundColor ?? style.backgroundColor;
    final shape = widget.style?.shape ?? style.shape!;
    final contentColor = widget.style?.contentColor ?? style.contentColor;
    final shadows = widget.style?.shadows ?? style.shadows;
    final backgroundColorDuration =
        Duration(milliseconds: backgroundColorAnimated ? 10 : 0);

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
                Positioned.fill(
                  child: AnimatedContainer(
                    duration: backgroundColorDuration,
                    decoration: ShapeDecoration(
                      color: backgroundColor,
                      shape: shape,
                      shadows: shadows,
                    ),
                  ),
                ),

                // State layer
                Positioned.fill(
                  child: Container(
                    decoration: ShapeDecoration(
                      color: overlayColor,
                      shape: shape,
                    ),
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
