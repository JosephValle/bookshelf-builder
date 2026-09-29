import 'package:bookshelf_builder/features/planner/data/services/system_clipboard_writer.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SystemClipboardWriter', () {
    test('sends the text through the clipboard channel', () async {
      final calls = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, (call) async {
            calls.add(call);
            return null;
          });
      addTearDown(() {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(SystemChannels.platform, null);
      });

      await const SystemClipboardWriter().write('hello');

      expect(calls.single.method, 'Clipboard.setData');
      expect((calls.single.arguments as Map)['text'], 'hello');
    });
  });
}
