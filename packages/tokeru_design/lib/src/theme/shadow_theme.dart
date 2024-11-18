import 'package:flutter/material.dart';

class TokeruShadowExtension extends ThemeExtension<TokeruShadowExtension> {
  TokeruShadowExtension({
    required this.w100,
    required this.w200,
    required this.w300,
    required this.w400,
    required this.w500,
    required this.w600,
  });

  List<BoxShadow> w100;
  List<BoxShadow> w200;
  List<BoxShadow> w300;
  List<BoxShadow> w400;
  List<BoxShadow> w500;
  List<BoxShadow> w600;

  @override
  ThemeExtension<TokeruShadowExtension> copyWith({
    List<BoxShadow>? w100,
    List<BoxShadow>? w200,
    List<BoxShadow>? w300,
    List<BoxShadow>? w400,
    List<BoxShadow>? w500,
    List<BoxShadow>? w600,
  }) {
    return TokeruShadowExtension(
      w100: w100 ?? this.w100,
      w200: w200 ?? this.w200,
      w300: w300 ?? this.w300,
      w400: w400 ?? this.w400,
      w500: w500 ?? this.w500,
      w600: w600 ?? this.w600,
    );
  }

  @override
  ThemeExtension<TokeruShadowExtension> lerp(
    covariant ThemeExtension<TokeruShadowExtension>? other,
    double t,
  ) {
    return this;
  }
}
