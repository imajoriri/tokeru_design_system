import 'package:flutter/material.dart';

abstract class TokeruPrimitiveColors {
  static const grey = MaterialColor(
    _greyPrimaryValue,
    <int, Color>{
      50: Color(0xFFFAFAFA),
      100: Color(0xFFF5F5F5),
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
      50: const Color(0xFF0C0C0D).withOpacity(0.05),
      100: const Color(0xFF0C0C0D).withOpacity(0.1),
      200: const Color(0xFF0C0C0D).withOpacity(0.2),
      300: const Color(0xFF0C0C0D).withOpacity(0.4),
      400: const Color(0xFF0C0C0D).withOpacity(0.7),
      500: const Color(0xFF0C0C0D).withOpacity(0.8),
      600: const Color(0xFF0C0C0D).withOpacity(0.85),
      700: const Color(0xFF0C0C0D).withOpacity(0.9),
      800: const Color(0xFF0C0C0D).withOpacity(0.95),
      900: const Color(0xFF0C0C0D),
    },
  );
  static const int _blackPrimaryValue = 0xFF0C0C0D;
}