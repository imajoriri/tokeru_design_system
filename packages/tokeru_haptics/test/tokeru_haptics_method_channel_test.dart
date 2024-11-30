import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tokeru_haptics/tokeru_haptics_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelTokeruHaptics platform = MethodChannelTokeruHaptics();
  const MethodChannel channel = MethodChannel('tokeru_haptics');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
