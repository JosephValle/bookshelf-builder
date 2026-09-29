import 'package:bookshelf_builder/features/planner/data/services/pdf_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../support/pdf_text.dart';

void main() {
  group('PdfCard', () {
    test('renders the title and its children', () async {
      final bytes = await renderWidgets([
        PdfCard.build(
          title: 'Plywood card',
          children: [pw.Text('inside text')],
        ),
      ]);
      final text = pdfText(bytes);
      expect(text, contains('Plywood card'));
      expect(text, contains('inside text'));
    });

    test('a card with no children still renders', () async {
      final bytes = await renderWidgets([
        PdfCard.build(title: 'Empty', children: const []),
      ]);
      expect(pdfText(bytes), contains('Empty'));
    });

    test('renders a chip with its text', () async {
      final bytes = await renderWidgets([PdfCard.chip('ZIP 33713')]);
      expect(pdfText(bytes), contains('ZIP 33713'));
    });

    test('several cards render on one page', () async {
      final bytes = await renderWidgets([
        PdfCard.build(title: 'One', children: [pw.Text('a')]),
        PdfCard.build(title: 'Two', children: [pw.Text('b')]),
      ]);
      final text = pdfText(bytes);
      expect(text, contains('One'));
      expect(text, contains('Two'));
    });
  });
}
