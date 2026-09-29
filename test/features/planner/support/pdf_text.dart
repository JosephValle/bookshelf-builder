import 'dart:convert';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Renders [children] on a letter page into an uncompressed PDF and returns
/// its bytes, so tests can search for text.
Future<Uint8List> renderWidgets(List<pw.Widget> children) async {
  final doc = pw.Document(compress: false);
  doc.addPage(
    pw.MultiPage(pageFormat: PdfPageFormat.letter, build: (_) => children),
  );
  return doc.save();
}

/// Rebuilds the text of an uncompressed PDF.
///
/// The `pdf` package writes each word as its own `[(word)]TJ` run, so this
/// joins the runs in page order with single spaces. Escaped parentheses and
/// backslashes are restored.
String pdfText(Uint8List bytes) {
  final raw = latin1.decode(bytes, allowInvalid: true);
  final words = RegExp(r'\[\((.*?)\)\]TJ')
      .allMatches(raw)
      .map(
        (m) =>
            m.group(1)!.replaceAllMapped(RegExp(r'\\(.)'), (e) => e.group(1)!),
      );
  return words.join(' ');
}
