import 'package:bookshelf_builder/features/planner/data/services/pdf_styles.dart';
import 'package:pdf/widgets.dart' as pw;

/// A label on the left and a right-aligned value, with an optional muted
/// caption. [emphasis] makes it bold and larger, for totals.
class PdfKeyValueRow {
  const PdfKeyValueRow._();

  /// Builds the row.
  static pw.Widget build({
    required String label,
    required String value,
    String? caption,
    bool emphasis = false,
  }) {
    final labelStyle = emphasis ? PdfStyles.total : PdfStyles.body;
    final valueStyle = emphasis ? PdfStyles.total : PdfStyles.strong;
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(label, style: labelStyle),
                if (caption != null) pw.Text(caption, style: PdfStyles.caption),
              ],
            ),
          ),
          pw.SizedBox(width: 10),
          pw.Text(value, style: valueStyle, textAlign: pw.TextAlign.right),
        ],
      ),
    );
  }
}
