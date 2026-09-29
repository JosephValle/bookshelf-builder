/// Port for putting text on the system clipboard.
abstract class ClipboardWriter {
  /// Copies [text] to the clipboard.
  Future<void> write(String text);
}
