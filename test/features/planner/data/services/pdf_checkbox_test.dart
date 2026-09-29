import 'package:bookshelf_builder/features/planner/data/services/pdf_checkbox.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/pdf_text.dart';

void main() {
  group('PdfCheckbox', () {
    test('builds a box of the requested size', () async {
      final bytes = await renderWidgets([
        PdfCheckbox.build(),
        PdfCheckbox.build(size: 14),
      ]);
      expect(bytes, isNotEmpty);
    });
  });
}
