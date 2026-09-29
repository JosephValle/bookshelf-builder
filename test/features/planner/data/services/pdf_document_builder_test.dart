import 'dart:convert';

import 'package:bookshelf_builder/features/planner/data/services/pdf_document_builder.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  const builder = PdfDocumentBuilder();

  group('build', () {
    test('produces a PDF', () async {
      final bytes = await builder.build(planFor());
      expect(ascii.decode(bytes.sublist(0, 5)), '%PDF-');
      expect(bytes.length, greaterThan(1000));
    });

    test('handles every optional feature', () async {
      final bytes = await builder.build(
        planFor(
          const Inputs(
            edgeStiffener: true,
            onFloor: false,
            left: 8,
            windowW: 70,
            wallW: 100,
            wallH: 90,
          ),
        ),
      );
      expect(bytes, isNotEmpty);
    });

    test('bigger plans still build', () async {
      final bytes = await builder.build(
        planFor(const Inputs(windowW: 60, windowH: 90, left: 40)),
      );
      expect(bytes, isNotEmpty);
    });
  });
}
