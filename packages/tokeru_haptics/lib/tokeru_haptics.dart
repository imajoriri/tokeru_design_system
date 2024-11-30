import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tokeru_haptics_platform_interface.dart';

const double heavy = 1;
const double medium = 0.6;
const double light = 0.3;

const double rigid = 0.8;
const double soft = 0.2;

class TokeruHaptics {
  Future<String?> getPlatformVersion() {
    return TokeruHapticsPlatform.instance.getPlatformVersion();
  }

  static Future<void> rigidHeavy() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      HapticFeedback.heavyImpact();
    }
    return vibrate(
      sharpness: rigid,
      intensity: heavy,
    );
  }

  static Future<void> rigidMedium() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      HapticFeedback.mediumImpact();
    }
    return vibrate(
      sharpness: rigid,
      intensity: medium,
    );
  }

  static Future<void> rigidLight() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      HapticFeedback.lightImpact();
    }
    return vibrate(
      sharpness: rigid,
      intensity: light,
    );
  }

  static Future<void> softHeavy() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      HapticFeedback.heavyImpact();
    }
    return vibrate(
      sharpness: soft,
      intensity: heavy,
    );
  }

  static Future<void> softMedium() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      HapticFeedback.mediumImpact();
    }
    return vibrate(
      sharpness: soft,
      intensity: medium,
    );
  }

  static Future<void> softLight() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      HapticFeedback.lightImpact();
    }
    return vibrate(
      sharpness: soft,
      intensity: light,
    );
  }

  static Future<void> vibrate({
    required double sharpness,
    required double intensity,
  }) async {
    return TokeruHapticsPlatform.instance.vibrate(
      sharpness: sharpness,
      intensity: intensity,
    );
  }
}
