import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// アニメーション開始までの遅延時間を指定できるScaleInアニメーション
class TokeruScaleIn extends StatefulWidget {
  /// 画面上で最初に表示されるWidgetに指定する。
  const TokeruScaleIn.first({
    super.key,
    required this.child,
  }) : delay = const Duration(milliseconds: 0);

  /// 画面上で2番目に表示されるWidgetに指定する。
  const TokeruScaleIn.second({
    super.key,
    required this.child,
  }) : delay = const Duration(milliseconds: 300);

  /// アニメーション対象のWidget
  final Widget child;

  /// アニメーション開始までの遅延時間
  final Duration delay;

  @override
  State<TokeruScaleIn> createState() => _TokeruScaleInState();
}

class _TokeruScaleInState extends State<TokeruScaleIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(
      vsync: this,
    );
    _scale = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    Future.delayed(widget.delay, () {
      final spring = SpringDescription.withDampingRatio(
        mass: 1.0,
        stiffness: 120,
        ratio: 0.8,
      );
      final springSimulation = SpringSimulation(
        spring,
        0,
        1,
        0,
      );
      _controller.animateWith(springSimulation);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: widget.child,
    );
  }
}
