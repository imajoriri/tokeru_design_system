import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tokeru_haptics_platform_interface.dart';

const double _heavy = 1;
const double _medium = 0.6;
const double _light = 0.3;

const double _rigid = 0.8;
const double _soft = 0.2;

class TokeruHaptics {
  Future<String?> getPlatformVersion() {
    return TokeruHapticsPlatform.instance.getPlatformVersion();
  }

  static Future<void> rigidHeavy() async {
    return vibrate(
      sharpness: _rigid,
      intensity: _heavy,
    );
  }

  static Future<void> rigidMedium() async {
    return vibrate(
      sharpness: _rigid,
      intensity: _medium,
    );
  }

  static Future<void> rigidLight() async {
    return vibrate(
      sharpness: _rigid,
      intensity: _light,
    );
  }

  static Future<void> softHeavy() async {
    return vibrate(
      sharpness: _soft,
      intensity: _heavy,
    );
  }

  static Future<void> softMedium() async {
    return vibrate(
      sharpness: _soft,
      intensity: _medium,
    );
  }

  static Future<void> softLight() async {
    return vibrate(
      sharpness: _soft,
      intensity: _light,
    );
  }

  static Future<void> success() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      HapticFeedback.lightImpact();
    }
    return TokeruHapticsPlatform.instance.success();
  }

  static Future<void> warning() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      HapticFeedback.mediumImpact();
    }
    return TokeruHapticsPlatform.instance.warning();
  }

  static Future<void> error() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      HapticFeedback.heavyImpact();
    }
    return TokeruHapticsPlatform.instance.error();
  }

  static Future<void> vibrate({
    required double sharpness,
    required double intensity,
  }) async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      if (intensity <= _light) {
        HapticFeedback.lightImpact();
      } else if (intensity >= _heavy) {
        HapticFeedback.heavyImpact();
      } else {
        HapticFeedback.mediumImpact();
      }
    }
    return TokeruHapticsPlatform.instance.vibrate(
      sharpness: sharpness,
      intensity: intensity,
    );
  }
}
