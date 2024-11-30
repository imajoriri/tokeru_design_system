import 'package:flutter_test/flutter_test.dart';
import 'package:tokeru_haptics/tokeru_haptics.dart';
import 'package:tokeru_haptics/tokeru_haptics_platform_interface.dart';
import 'package:tokeru_haptics/tokeru_haptics_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTokeruHapticsPlatform
    with MockPlatformInterfaceMixin
    implements TokeruHapticsPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> vibrate({required double sharpness, required double intensity}) {
    throw UnimplementedError();
  }
}

void main() {
  final TokeruHapticsPlatform initialPlatform = TokeruHapticsPlatform.instance;

  test('$MethodChannelTokeruHaptics is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTokeruHaptics>());
  });

  test('getPlatformVersion', () async {
    TokeruHaptics tokeruHapticsPlugin = TokeruHaptics();
    MockTokeruHapticsPlatform fakePlatform = MockTokeruHapticsPlatform();
    TokeruHapticsPlatform.instance = fakePlatform;

    expect(await tokeruHapticsPlugin.getPlatformVersion(), '42');
  });
}
