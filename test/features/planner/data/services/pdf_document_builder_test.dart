import 'dart:convert';

import 'package:bookshelf_builder/features/planner/data/services/pdf_document_builder.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/pdf_text.dart';
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

    test('contains the styled materials, cost and tools cards', () async {
      const plain = PdfDocumentBuilder(compress: false);
      final text = pdfText(await plain.build(planFor()));
      for (final needle in [
        'Materials',
        'Plywood',
        'Estimated cost',
        'Estimated total',
        'Recommended tools',
        'Assembly guide',
        'Buying',
        'Wall attachment',
        'Cut list',
      ]) {
        expect(text, contains(needle), reason: needle);
      }
    });

    test('the cut list has piece ids and the guide has pictures', () async {
      const plain = PdfDocumentBuilder(compress: false);
      final text = pdfText(await plain.build(planFor()));
      expect(text, contains('Piece'));
      expect(text, contains('B1-B2'));
      expect(text, contains('Screw placement'));
      expect(text, contains('Left column: attach shelf D1 to B1'));
    });

    test('the cards come before the assembly guide', () async {
      const plain = PdfDocumentBuilder(compress: false);
      final text = pdfText(await plain.build(planFor()));
      expect(
        text.indexOf('Estimated cost'),
        lessThan(text.indexOf('Assembly guide')),
      );
      expect(
        text.indexOf('Recommended tools'),
        lessThan(text.indexOf('Assembly guide')),
      );
    });

    test('compressing shrinks the file', () async {
      final small = await const PdfDocumentBuilder().build(planFor());
      final big = await const PdfDocumentBuilder(compress: false)
          .build(planFor());
      expect(small.length, lessThan(big.length));
    });

    test('still ends with the disclaimer', () async {
      const plain = PdfDocumentBuilder(compress: false);
      final text = pdfText(await plain.build(planFor()));
      expect(text, contains('rules of thumb'));
    });
  });

  group('guide layout', () {
    test('has tools, hardware, checkpoints and the piece map', () async {
      const plain = PdfDocumentBuilder(compress: false);
      final text = pdfText(await plain.build(planFor()));
      expect(text, contains('Tools'));
      expect(text, contains('Hardware'));
      expect(text, contains('Checkpoint: the left column'));
      expect(text, contains('Where every piece goes'));
      expect(text, contains('pieces with the same letter are identical'));
    });

    test(
      'the piece map comes after the guide and before the warnings',
      () async {
        const plain = PdfDocumentBuilder(compress: false);
        final text = pdfText(await plain.build(planFor()));
        final guide = text.indexOf('Finish and check');
        final map = text.indexOf('Where every piece goes');
        final warnings = text.indexOf('Warnings');
        expect(guide, lessThan(map));
        expect(map, lessThan(warnings));
      },
    );

    test('lists the supplies with screw sizes and quantities', () async {
      const plain = PdfDocumentBuilder(compress: false);
      final text = pdfText(await plain.build(planFor()));
      expect(text, contains('Supplies to buy'));
      expect(text, contains('#8 x 1-1/4" cabinet screws'));
      expect(text, contains('box of 100'));
      expect(text, contains('countersink'));
    });

    test('a concrete wall changes the wall note and the wall steps', () async {
      const plain = PdfDocumentBuilder(compress: false);
      final text = pdfText(
        await plain.build(planFor(const Inputs(concreteWall: true))),
      );
      expect(text, contains('Mount: check the wall'));
      expect(text, contains('concrete screws'));
      expect(text, contains('mortar'));
    });
  });

  group('cutting layout in the guide', () {
    test('has a picture step for every sheet', () async {
      const plain = PdfDocumentBuilder(compress: false);
      final text = pdfText(await plain.build(planFor()));
      expect(text, contains('Cut 3/4" sheet 1 of 3'));
      expect(text, contains('Cut 1/4" sheet 1 of 1'));
      expect(text, contains('drawn to scale'));
    });

    test('a layout with oversize backs still builds', () async {
      final bytes = await builder.build(planFor(Inputs.home));
      expect(bytes, isNotEmpty);
    });
  });
}
