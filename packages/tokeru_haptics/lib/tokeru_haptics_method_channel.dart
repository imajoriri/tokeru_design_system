import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tokeru_haptics_platform_interface.dart';

/// An implementation of [TokeruHapticsPlatform] that uses method channels.
class MethodChannelTokeruHaptics extends TokeruHapticsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tokeru_haptics');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> vibrate({
    required double sharpness,
    required double intensity,
  }) async {
    await methodChannel.invokeMethod<void>(
      'vibrate',
      {
        'sharpness': sharpness,
        'intensity': intensity,
      },
    );
  }

  @override
  Future<void> success() async {
    await methodChannel.invokeMethod<void>('success');
  }

  @override
  Future<void> warning() async {
    await methodChannel.invokeMethod<void>('warning');
  }

  @override
  Future<void> error() async {
    await methodChannel.invokeMethod<void>('error');
  }
}
