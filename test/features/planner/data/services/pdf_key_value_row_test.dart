import 'package:bookshelf_builder/features/planner/data/services/pdf_key_value_row.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/pdf_text.dart';

void main() {
  group('PdfKeyValueRow', () {
    test('renders the label and value', () async {
      final text = pdfText(
        await renderWidgets([
          PdfKeyValueRow.build(label: 'Plywood', value: '3 sheets'),
        ]),
      );
      expect(text, contains('Plywood'));
      expect(text, contains('3 sheets'));
    });

    test('renders the caption when given', () async {
      final text = pdfText(
        await renderWidgets([
          PdfKeyValueRow.build(
            label: 'Plywood',
            value: '3 sheets',
            caption: 'per 4x8 sheet',
          ),
        ]),
      );
      expect(text, contains('per 4x8 sheet'));
    });

    test('an emphasized row renders too', () async {
      final text = pdfText(
        await renderWidgets([
          PdfKeyValueRow.build(
            label: 'Estimated total',
            value: r'$261.68',
            emphasis: true,
          ),
        ]),
      );
      expect(text, contains('Estimated total'));
      expect(text, contains(r'$261.68'));
    });

    test('a very long label does not throw', () async {
      final bytes = await renderWidgets([
        PdfKeyValueRow.build(label: 'long ' * 60, value: '1'),
      ]);
      expect(bytes, isNotEmpty);
    });
  });
}
