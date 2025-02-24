import 'package:flutter/material.dart';
import 'package:tokeru_design/tokeru_design.dart';

/// [Text]の箇所で使用するスケルトンUI。
class SkeletonText extends StatelessWidget {
  /// 幅。
  final double width;

  /// [Text]で使用しているスタイル。
  final TextStyle style;

  /// 行数。
  final int lineLength;

  /// コンストラクタ。
  const SkeletonText({
    super.key,
    required this.width,
    required this.style,
    this.lineLength = 1,
  });

  @override
  Widget build(BuildContext context) {
    // フォントサイズと行の高さからパディングを計算
    final padding =
        (style.fontSize! * (style.height ?? 1.4) - style.fontSize!) * 0.5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < lineLength; i++)
          Container(
            constraints: BoxConstraints(maxWidth: width),
            padding: EdgeInsets.symmetric(vertical: padding),
            child: Container(
              height: style.fontSize!,
              decoration: BoxDecoration(
                color: context.tokeruColors.skeleton,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
      ],
    );
  }
}
