import 'package:flutter/material.dart';

abstract class TokeruPrimitiveColors {
  static const white = Color(0xFFFFFFFF);

  static const grey = MaterialColor(
    _greyPrimaryValue,
    <int, Color>{
      50: Color(0xFFF5F5F5),
      100: Color(0xFFE5E5E5),
      200: Color(0xFFD9D9D9),
      300: Color(0xFFB2B2B2),
      400: Color(0xFF757575),
      500: Color(_greyPrimaryValue),
      600: Color(0xFF383838),
      700: Color(0xFF2B2B2B),
      800: Color(0xFF1E1E1E),
      900: Color(0xFF111111),
    },
  );
  static const int _greyPrimaryValue = 0xFF454545;

  static final black = MaterialColor(
    _blackPrimaryValue,
    <int, Color>{
      50: const Color(0xFF0C0C0D).withValues(alpha: 0.05),
      100: const Color(0xFF0C0C0D).withValues(alpha: 0.1),
      200: const Color(0xFF0C0C0D).withValues(alpha: 0.2),
      300: const Color(0xFF0C0C0D).withValues(alpha: 0.4),
      400: const Color(0xFF0C0C0D).withValues(alpha: 0.7),
      500: const Color(0xFF0C0C0D).withValues(alpha: 0.8),
      600: const Color(0xFF0C0C0D).withValues(alpha: 0.85),
      700: const Color(0xFF0C0C0D).withValues(alpha: 0.9),
      800: const Color(0xFF0C0C0D).withValues(alpha: 0.95),
      900: const Color(0xFF0C0C0D),
    },
  );
  static const int _blackPrimaryValue = 0xFF0C0C0D;

  static const red = MaterialColor(
    _redPrimaryValue,
    <int, Color>{
      50: Color(0xFFFFF0F3),
      100: Color(0xFFFFDBE1),
      200: Color(0xFFFFBFC3),
      300: Color(0xFFFF999F),
      400: Color(0xFFFF737C),
      500: Color(_redPrimaryValue),
      600: Color(0xFFEB1D35),
      700: Color(0xFFC20B2A),
      800: Color(0xFF99001D),
      900: Color(0xFF66000E),
    },
  );
  static const int _redPrimaryValue = 0xFFFF4D58;

  static const green = MaterialColor(
    _greenPrimaryValue,
    <int, Color>{
      50: Color(0xFFEEFAEC),
      100: Color(0xFFDAF2D6),
      200: Color(0xFFC2E5BC),
      300: Color(0xFFA9D9A1),
      400: Color(0xFF7FC673),
      500: Color(_greenPrimaryValue),
      600: Color(0xFF2AA315),
      700: Color(0xFF218011),
      800: Color(0xFF195E0D),
      900: Color(0xFF0F3D08),
    },
  );
  static const int _greenPrimaryValue = 0xFF55B545;
}
