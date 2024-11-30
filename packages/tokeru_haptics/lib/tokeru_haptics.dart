import 'tokeru_haptics_platform_interface.dart';

const double heavy = 1;
const double medium = 0.7;
const double light = 0.3;

const double rigid = 1;
const double soft = 0;

class TokeruHaptics {
  Future<String?> getPlatformVersion() {
    return TokeruHapticsPlatform.instance.getPlatformVersion();
  }

  static Future<void> rigidHeavy() async {
    return vibrate(
      sharpness: rigid,
      intensity: heavy,
    );
  }

  static Future<void> rigidMedium() async {
    return vibrate(
      sharpness: rigid,
      intensity: medium,
    );
  }

  static Future<void> rigidLight() async {
    return vibrate(
      sharpness: rigid,
      intensity: light,
    );
  }

  static Future<void> softHeavy() async {
    return vibrate(
      sharpness: soft,
      intensity: heavy,
    );
  }

  static Future<void> softMedium() async {
    return vibrate(
      sharpness: soft,
      intensity: medium,
    );
  }

  static Future<void> softLight() async {
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
