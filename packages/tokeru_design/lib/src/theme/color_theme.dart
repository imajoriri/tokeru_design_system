import 'package:flutter/material.dart';

class TokeruColorsExtension extends ThemeExtension<TokeruColorsExtension> {
  TokeruColorsExtension({
    // Primary
    required this.primary,
    required this.onPrimary,

    // Secondary
    required this.secondary,
    required this.onSecondary,

    // surface
    required this.surface,
    required this.onSurface,
    required this.onSurfaceSubtle,

    // outline
    required this.outline,
    required this.outlineSubtle,
    required this.outlineStrong,

    // others
    required this.link,
    required this.skeleton,
    required this.background,
    required this.onBackground,

    // error
    required this.error,
    required this.onError,

    // success
    required this.success,
    required this.onSuccess,
  });

  // Primary
  final Color primary;
  final Color onPrimary;

  // Secondary
  final Color secondary;
  final Color onSecondary;

  // surface
  final Color surface;
  final Color onSurface;
  final Color onSurfaceSubtle;

  // outline
  final Color outline;
  final Color outlineSubtle;
  final Color outlineStrong;

  // others
  final Color link;
  final Color skeleton;

  /// 背景色
  final Color background;

  /// 背景色のテキストカラー
  final Color onBackground;

  // error
  final Color error;
  final Color onError;

  // success
  final Color success;
  final Color onSuccess;

  @override
  ThemeExtension<TokeruColorsExtension> copyWith({
    // Primary
    Color? primary,
    Color? onPrimary,

    // Secondary
    Color? secondary,
    Color? onSecondary,

    // surface
    Color? surface,
    Color? onSurface,
    Color? onSurfaceSubtle,

    // outline
    Color? outline,
    Color? outlineSubtle,
    Color? outlineStrong,

    // others
    Color? link,
    Color? skeleton,
    Color? background,
    Color? onBackground,

    // error
    Color? error,
    Color? onError,

    // success
    Color? success,
    Color? onSuccess,
  }) {
    return TokeruColorsExtension(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceSubtle: onSurfaceSubtle ?? this.onSurfaceSubtle,
      outline: outline ?? this.outline,
      outlineSubtle: outlineSubtle ?? this.outlineSubtle,
      outlineStrong: outlineStrong ?? this.outlineStrong,
      link: link ?? this.link,
      skeleton: skeleton ?? this.skeleton,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
    );
  }

  @override
  ThemeExtension<TokeruColorsExtension> lerp(
    covariant ThemeExtension<TokeruColorsExtension>? other,
    double t,
  ) {
    return this;
  }
}
