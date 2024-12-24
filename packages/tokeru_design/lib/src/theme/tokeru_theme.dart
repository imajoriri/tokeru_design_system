import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokeru_design/src/theme/color_const.dart';
import 'package:tokeru_design/src/theme/color_theme.dart';
import 'package:tokeru_design/src/theme/shadow_theme.dart';
import 'package:tokeru_design/src/theme/spacing_theme.dart';
import 'package:tokeru_design/src/theme/text_theme.dart';

/// TokeruDesignSystemのテーマ。
///
/// ```dart
/// MaterialApp(
///   title: 'Flutter Demo',
///   theme: TokeruTheme.light,
///   darkTheme: TokeruTheme.dark,
///   themeMode: ThemeMode.light,
///   home: const MyHomePage(),
/// );
/// ```
class TokeruTheme {
  static final spacing = () {
    return TokeruSpacingExtension(
      none: 0,
      smallX: 4,
      small: 8,
      medium: 16,
      large: 24,
    );
  }();

  static final shadow = () {
    return TokeruShadowExtension(
      w100: [
        BoxShadow(
          offset: const Offset(0, 1),
          blurRadius: 4,
          color: TokeruPrimitiveColors.black.shade50,
        ),
      ],
      w200: [
        BoxShadow(
          offset: const Offset(0, 1),
          blurRadius: 4,
          color: TokeruPrimitiveColors.black.shade100,
        ),
        BoxShadow(
          offset: const Offset(0, 1),
          blurRadius: 4,
          color: TokeruPrimitiveColors.black.shade50,
        ),
      ],
      w300: [
        BoxShadow(
          offset: const Offset(0, 4),
          blurRadius: 4,
          spreadRadius: -1,
          color: TokeruPrimitiveColors.black.shade100,
        ),
        BoxShadow(
          offset: const Offset(0, 4),
          blurRadius: 4,
          spreadRadius: -1,
          color: TokeruPrimitiveColors.black.shade50,
        ),
      ],
      w400: [
        BoxShadow(
          offset: const Offset(0, 16),
          blurRadius: 32,
          spreadRadius: -4,
          color: TokeruPrimitiveColors.black.shade100,
        ),
        BoxShadow(
          offset: const Offset(0, 4),
          blurRadius: 4,
          spreadRadius: -4,
          color: TokeruPrimitiveColors.black.shade50,
        ),
      ],
      w500: [
        BoxShadow(
          offset: const Offset(0, 16),
          blurRadius: 16,
          spreadRadius: -8,
          color: TokeruPrimitiveColors.black.shade100,
        ),
        BoxShadow(
          offset: const Offset(0, 4),
          blurRadius: 4,
          spreadRadius: -4,
          color: TokeruPrimitiveColors.black.shade50,
        ),
      ],
      w600: [
        BoxShadow(
          offset: const Offset(0, 16),
          blurRadius: 32,
          spreadRadius: -16,
          color: TokeruPrimitiveColors.black.shade300,
        ),
      ],
    );
  }();

  static final color = () {
    return TokeruColorsExtension(
      // primary
      primary: Colors.cyan.shade500,
      onPrimary: TokeruPrimitiveColors.white,
      onPrimarySubtle: TokeruPrimitiveColors.grey.shade50,
      primaryOutline: TokeruPrimitiveColors.white,

      // secondary
      secondary: TokeruPrimitiveColors.grey.shade50,
      onSecondary: TokeruPrimitiveColors.grey.shade900,
      onSecondarySubtle: TokeruPrimitiveColors.grey.shade400,
      secondaryOutline: TokeruPrimitiveColors.grey.shade100,

      // surface
      surface: TokeruPrimitiveColors.white,
      onSurface: TokeruPrimitiveColors.grey.shade900,
      onSurfaceSubtle: TokeruPrimitiveColors.grey.shade400,
      surfaceOutline: TokeruPrimitiveColors.grey.shade100,

      // outline
      outline: TokeruPrimitiveColors.grey.shade300,
      outlineSubtle: TokeruPrimitiveColors.grey.shade200,
      outlineStrong: TokeruPrimitiveColors.grey.shade400,

      // link
      link: Colors.blue.shade800,

      // skeleton
      skeleton: Colors.grey.shade100,

      // background
      background: TokeruPrimitiveColors.grey.shade50,
      onBackground: Colors.grey.shade900,

      // error
      error: TokeruPrimitiveColors.red.shade50,
      onError: TokeruPrimitiveColors.red.shade500,

      // success
      success: TokeruPrimitiveColors.green.shade500,
      onSuccess: Colors.white,
    );
  }();

  static final text = () {
    return const TokeruTextThemeExtension(
      displayLarge: TextStyle(fontSize: 57),
      displayMedium: TextStyle(fontSize: 45),
      displaySmall: TextStyle(fontSize: 36),
      headlineLarge: TextStyle(fontSize: 32),
      headlineMedium: TextStyle(fontSize: 28),
      headlineSmall: TextStyle(fontSize: 24),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
      bodySmall: TextStyle(fontSize: 12),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      labelMidium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    );
  }();

  static final light = () {
    final defaultTheme = ThemeData.light();

    final colorExt = color;

    return defaultTheme.copyWith(
      dividerColor: colorExt.outline,
      textTheme: defaultTheme.textTheme.copyWith(
        bodyLarge: TextStyle(
          fontFamily: 'Hiragino Kaku Gothic ProN',
          color: colorExt.onSurface,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorExt.surface,
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        scaffoldBackgroundColor: colorExt.surface,
        primaryColor: colorExt.primary,
        primaryContrastingColor: colorExt.onPrimary,
        barBackgroundColor: colorExt.background,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorExt.primary,
        linearTrackColor: colorExt.background,
        linearMinHeight: 2,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorExt.onSurface,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: text.bodyMedium.copyWith(
          color: colorExt.onSurfaceSubtle,
        ),
      ),
      extensions: [
        colorExt,
        spacing,
        shadow,
        text,
      ],
    );
  }();

  static final dark = () {
    final defaultTheme = ThemeData.dark();

    final colorExt = color;

    return defaultTheme.copyWith(
      extensions: [
        colorExt,
        spacing,
        shadow,
        text,
      ],
    );
  }();
}

extension TokeruThemeExtension on BuildContext {
  TokeruTextThemeExtension get tokeruTextTheme {
    return Theme.of(this).extension<TokeruTextThemeExtension>()!;
  }

  TokeruColorsExtension get tokeruColors {
    return Theme.of(this).extension<TokeruColorsExtension>()!;
  }

  TokeruSpacingExtension get tokeruSpacing {
    return Theme.of(this).extension<TokeruSpacingExtension>()!;
  }

  TokeruShadowExtension get tokeruShadow {
    return Theme.of(this).extension<TokeruShadowExtension>()!;
  }
}
