import 'package:bookshelf_builder/features/planner/domain/services/clipboard_writer.dart';

/// Records writes instead of touching the system clipboard.
class FakeClipboardWriter implements ClipboardWriter {
  /// Texts written so far.
  final List<String> writes = [];

  /// When true, [write] throws.
  bool fail = false;

  @override
  Future<void> write(String text) async {
    if (fail) throw StateError('clipboard unavailable');
    writes.add(text);
  }
}
