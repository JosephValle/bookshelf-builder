import 'package:bookshelf_builder/features/planner/domain/services/clipboard_writer.dart';
import 'package:flutter/services.dart';

/// Writes to the real system clipboard through Flutter's platform channel.
class SystemClipboardWriter implements ClipboardWriter {
  /// Creates a writer.
  const SystemClipboardWriter();

  @override
  Future<void> write(String text) =>
      Clipboard.setData(ClipboardData(text: text));
}
