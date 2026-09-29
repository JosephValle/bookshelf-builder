import 'package:bookshelf_builder/features/planner/data/services/pdf_document_builder.dart';
import 'package:bookshelf_builder/features/planner/data/services/printing_pdf_exporter.dart';
import 'package:bookshelf_builder/features/planner/domain/services/pdf_exporter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PrintingPdfExporter', () {
    test('implements the PdfExporter port', () {
      expect(const PrintingPdfExporter(), isA<PdfExporter>());
    });

    test('uses the given document builder', () {
      const builder = PdfDocumentBuilder();
      expect(const PrintingPdfExporter(builder: builder).builder, builder);
    });
  });
}
