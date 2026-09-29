import 'package:bookshelf_builder/features/planner/data/services/pdf_styles.dart';
import 'package:pdf/widgets.dart' as pw;

/// A titled, outlined box that groups one part of the materials section, the
/// PDF counterpart of the Materials tab cards.
class PdfCard {
  const PdfCard._();

  /// Builds a card with a [title] and its [children].
  static pw.Widget build({
    required String title,
    required List<pw.Widget> children,
  }) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 10),
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfStyles.border, width: 0.8),
        borderRadius: pw.BorderRadius.circular(PdfStyles.radius),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(title, style: PdfStyles.cardTitle),
          pw.SizedBox(height: 6),
          ...children,
        ],
      ),
    );
  }

  /// A small rounded label, used for the ZIP code and update date.
  static pw.Widget chip(String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: pw.BoxDecoration(
        color: PdfStyles.chipFill,
        border: pw.Border.all(color: PdfStyles.border, width: 0.5),
        borderRadius: pw.BorderRadius.circular(PdfStyles.radius),
      ),
      child: pw.Text(text, style: PdfStyles.caption),
    );
  }
}
