import 'package:bookshelf_builder/features/planner/data/services/pdf_checkbox.dart';
import 'package:bookshelf_builder/features/planner/data/services/pdf_diagram.dart';
import 'package:bookshelf_builder/features/planner/data/services/pdf_styles.dart';
import 'package:bookshelf_builder/features/planner/domain/models/assembly_step.dart';
import 'package:pdf/widgets.dart' as pw;

/// Lays out one assembly step: a tick box and title, the tools and hardware
/// it uses, the instructions and the pictures.
///
/// A checkpoint step is drawn in a box and every line of it gets its own tick
/// box, so it works as a checklist.
class PdfStep {
  const PdfStep._();

  static const pw.TextStyle _title = pw.TextStyle(
    fontSize: 12,
    fontWeight: pw.FontWeight.bold,
  );

  /// Builds step number [number] (one based).
  static pw.Widget build(int number, AssemblyStep step) {
    final head = pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        PdfCheckbox.build(size: 11),
        pw.SizedBox(width: 6),
        pw.Expanded(child: pw.Text('$number. ${step.title}', style: _title)),
      ],
    );
    final body = pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        head,
        pw.SizedBox(height: 3),
        if (step.tools.isNotEmpty) _list('Tools', step.tools),
        if (step.hardware.isNotEmpty) _list('Hardware', step.hardware),
        if (step.checkpoint)
          for (final d in step.details)
            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 2),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  PdfCheckbox.build(size: 8),
                  pw.SizedBox(width: 5),
                  pw.Expanded(child: pw.Text(d, style: PdfStyles.body)),
                ],
              ),
            )
        else
          for (final d in step.details) pw.Bullet(text: d),
        for (final diagram in step.diagrams)
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 6),
            child: PdfDiagram.build(diagram),
          ),
      ],
    );
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 10),
      child: step.checkpoint
          ? pw.Container(
              padding: const pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                color: PdfStyles.chipFill,
                border: pw.Border.all(color: PdfStyles.accent, width: 1.2),
                borderRadius: pw.BorderRadius.circular(PdfStyles.radius),
              ),
              child: body,
            )
          : body,
    );
  }

  /// A small shaded box listing tools or hardware, one per line.
  static pw.Widget _list(String label, List<String> items) => pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 3),
    child: pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: pw.BoxDecoration(
        color: PdfStyles.chipFill,
        border: pw.Border.all(color: PdfStyles.border, width: 0.5),
        borderRadius: pw.BorderRadius.circular(3),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(label, style: PdfStyles.strong),
          for (final item in items)
            pw.Text('- $item', style: PdfStyles.caption),
        ],
      ),
    ),
  );
}
