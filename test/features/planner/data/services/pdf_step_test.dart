import 'package:bookshelf_builder/features/planner/data/services/pdf_step.dart';
import 'package:bookshelf_builder/features/planner/domain/models/assembly_step.dart';
import 'package:bookshelf_builder/features/planner/domain/services/assembly_guide_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/pdf_text.dart';
import '../../support/plan_helpers.dart';

void main() {
  group('PdfStep', () {
    test(
      'writes the number, title, tools, hardware and instructions',
      () async {
        const step = AssemblyStep(
          'Attach the shelf',
          ['Stand it on its end.', 'Drive the screws.'],
          tools: ['Drill with a 1/8" bit: pilot holes'],
          hardware: ['3 x 1-1/4" screws'],
        );
        final text = pdfText(await renderWidgets([PdfStep.build(7, step)]));
        expect(text, contains('7. Attach the shelf'));
        expect(text, contains('Tools'));
        expect(text, contains('pilot holes'));
        expect(text, contains('Hardware'));
        expect(text, contains('3 x 1-1/4" screws'));
        expect(text, contains('Stand it on its end.'));
      },
    );

    test(
      'leaves out the tools and hardware boxes when there are none',
      () async {
        const step = AssemblyStep('Read this', ['Take your time.']);
        final text = pdfText(await renderWidgets([PdfStep.build(1, step)]));
        expect(text, isNot(contains('Tools')));
        expect(text, isNot(contains('Hardware')));
      },
    );

    test('draws a checkpoint with its checklist', () async {
      const step = AssemblyStep('Checkpoint: the column', [
        'It should look like the picture.',
        'The diagonals match.',
      ], checkpoint: true);
      final text = pdfText(await renderWidgets([PdfStep.build(3, step)]));
      expect(text, contains('3. Checkpoint: the column'));
      expect(text, contains('The diagonals match.'));
    });

    test('draws the pictures of a step', () async {
      final steps = const AssemblyGuideBuilder().build(planFor());
      final shelf = steps.firstWhere(
        (s) => s.title.startsWith('Left column: attach shelf D1'),
      );
      final text = pdfText(await renderWidgets([PdfStep.build(9, shelf)]));
      expect(text, contains('Screw placement'));
    });

    test('every step of a full guide lays out', () async {
      final steps = const AssemblyGuideBuilder().build(planFor());
      final bytes = await renderWidgets([
        for (var n = 0; n < steps.length; n++) PdfStep.build(n + 1, steps[n]),
      ]);
      expect(bytes, isNotEmpty);
    });
  });
}
