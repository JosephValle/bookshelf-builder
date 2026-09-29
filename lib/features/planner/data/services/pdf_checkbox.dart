import 'package:bookshelf_builder/features/planner/data/services/pdf_styles.dart';
import 'package:pdf/widgets.dart' as pw;

/// An empty square to tick with a pencil.
class PdfCheckbox {
  const PdfCheckbox._();

  /// Builds a checkbox [size] points wide.
  static pw.Widget build({double size = 10}) => pw.Container(
    width: size,
    height: size,
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfStyles.diagramInk, width: 0.8),
    ),
  );
}
