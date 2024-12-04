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
      primary: Colors.cyan.shade500,
      onPrimary: Colors.white,
      secondary: TokeruPrimitiveColors.grey.shade200,
      onSecondary: TokeruPrimitiveColors.grey.shade400,
      surface: Colors.white,
      onSurface: Colors.grey.shade900,
      onSurfaceSubtle: Colors.grey.shade600,
      outline: Colors.grey.shade300,
      outlineSubtle: Colors.grey.shade200,
      outlineStrong: Colors.grey.shade400,
      link: Colors.blue.shade800,
      skeleton: Colors.grey.shade300,
      background: TokeruPrimitiveColors.grey.shade100,
      onBackground: Colors.grey.shade900,
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
        bodyLarge: const TextStyle(fontFamily: 'Hiragino Kaku Gothic ProN'),
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
