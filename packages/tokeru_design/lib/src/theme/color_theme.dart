import 'package:flutter/material.dart';

class TokeruColorsExtension extends ThemeExtension<TokeruColorsExtension> {
  TokeruColorsExtension({
    // Primary
    required this.primary,
    required this.onPrimary,
    required this.onPrimarySubtle,
    required this.primaryOutline,

    // Secondary
    required this.secondary,
    required this.onSecondary,
    required this.onSecondarySubtle,
    required this.secondaryOutline,

    // surface
    required this.surface,
    required this.onSurface,
    required this.onSurfaceSubtle,
    required this.surfaceOutline,

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
  final Color onPrimarySubtle;
  final Color primaryOutline;

  // Secondary
  final Color secondary;
  final Color onSecondary;
  final Color onSecondarySubtle;
  final Color secondaryOutline;

  // surface
  final Color surface;
  final Color onSurface;
  final Color onSurfaceSubtle;
  final Color surfaceOutline;

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
    Color? onPrimarySubtle,
    Color? primaryOutline,

    // Secondary
    Color? secondary,
    Color? onSecondary,
    Color? onSecondarySubtle,
    Color? secondaryOutline,

    // surface
    Color? surface,
    Color? onSurface,
    Color? onSurfaceSubtle,
    Color? surfaceOutline,

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
      onPrimarySubtle: onPrimarySubtle ?? this.onPrimarySubtle,
      primaryOutline: primaryOutline ?? this.primaryOutline,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      onSecondarySubtle: onSecondarySubtle ?? this.onSecondarySubtle,
      secondaryOutline: secondaryOutline ?? this.secondaryOutline,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceSubtle: onSurfaceSubtle ?? this.onSurfaceSubtle,
      surfaceOutline: surfaceOutline ?? this.surfaceOutline,
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
