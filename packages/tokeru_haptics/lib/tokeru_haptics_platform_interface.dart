import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tokeru_haptics_method_channel.dart';

abstract class TokeruHapticsPlatform extends PlatformInterface {
  /// Constructs a TokeruHapticsPlatform.
  TokeruHapticsPlatform() : super(token: _token);

  static final Object _token = Object();

  static TokeruHapticsPlatform _instance = MethodChannelTokeruHaptics();

  /// The default instance of [TokeruHapticsPlatform] to use.
  ///
  /// Defaults to [MethodChannelTokeruHaptics].
  static TokeruHapticsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TokeruHapticsPlatform] when
  /// they register themselves.
  static set instance(TokeruHapticsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> vibrate({
    required double sharpness,
    required double intensity,
  }) async {
    throw UnimplementedError('vibrate() has not been implemented.');
  }

  Future<void> success() async {
    throw UnimplementedError('success() has not been implemented.');
  }

  Future<void> warning() async {
    throw UnimplementedError('warning() has not been implemented.');
  }

  Future<void> error() async {
    throw UnimplementedError('error() has not been implemented.');
  }
}
