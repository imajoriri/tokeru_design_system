import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tokeru_design/tokeru_design.dart';

/// チェックボタン。
class TokeruCheckButton extends StatefulWidget {
  const TokeruCheckButton({
    super.key,
    required this.checked,
    this.onChanged,
    this.uncheckedColor,
    this.checkedColor,
  });

  final bool checked;

  /// ボタンが押されたときの処理。
  final void Function(bool)? onChanged;

  /// チェックされていないときのカラー。
  final Color? uncheckedColor;

  /// チェックされているときのカラー。
  final Color? checkedColor;

  @override
  State<TokeruCheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends State<TokeruCheckButton> {
  bool pressed = false;
  late final FocusNode focusNode;

  static const animationDuration = Duration(milliseconds: 100);

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void onTapCheck() async {
    if (!pressed) {
      pressed = true;
      await Future.delayed(animationDuration);
    }
    pressed = false;
    widget.onChanged?.call(!widget.checked);
  }

  /// チェックされていないときのカラー。
  Color get uncheckedColor =>
      widget.uncheckedColor ?? context.tokeruColors.onSurface;

  /// チェックされているときのカラー。
  Color get checkedColor =>
      widget.checkedColor ?? context.tokeruColors.onSurface;

  @override
  Widget build(BuildContext context) {
    const minScale = 0.9;
    const widgetSize = 16.0;

    return GestureDetector(
      onTapDown: (detail) => pressed = true,
      onTapCancel: () => pressed = false,
      onTap: onTapCheck,
      child: FocusableActionDetector(
        focusNode: focusNode,
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
        },
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (intent) => onTapCheck.call(),
          ),
        },
        mouseCursor: widget.onChanged != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: AnimatedScale(
          duration: animationDuration,
          scale: widget.onChanged == null ? 1.0 : (pressed ? minScale : 1.0),
          child: AnimatedContainer(
            duration: animationDuration,
            width: widgetSize,
            height: widgetSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: widget.checked ? checkedColor : uncheckedColor,
                width: 2,
              ),
            ),
            alignment: Alignment.center,
            child: AnimatedOpacity(
              duration: animationDuration,
              opacity: widget.checked ? 1.0 : 0.0,
              child: Icon(
                Icons.check_rounded,
                size: 12,
                color: widget.checked ? checkedColor : uncheckedColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
