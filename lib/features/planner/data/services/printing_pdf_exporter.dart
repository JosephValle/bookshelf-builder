import 'package:bookshelf_builder/features/planner/data/services/pdf_document_builder.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:bookshelf_builder/features/planner/domain/services/pdf_exporter.dart';
import 'package:printing/printing.dart';

/// Exports the PDF through the platform print dialog (browser print on the
/// web, system print and save on macOS).
class PrintingPdfExporter implements PdfExporter {
  /// Creates an exporter.
  const PrintingPdfExporter({this.builder = const PdfDocumentBuilder()});

  /// Builds the document bytes.
  final PdfDocumentBuilder builder;

  @override
  Future<void> export(Plan plan) async {
    await Printing.layoutPdf(
      name: 'shelf_planner.pdf',
      onLayout: (format) => builder.build(plan),
    );
  }
}
