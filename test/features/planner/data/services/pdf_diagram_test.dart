import 'package:bookshelf_builder/features/planner/data/services/pdf_diagram.dart';
import 'package:bookshelf_builder/features/planner/domain/models/assembly_diagram.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_arrow.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_dimension.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_mark.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_mark_kind.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_piece.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_point.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_shape.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_tone.dart';
import 'package:bookshelf_builder/features/planner/domain/services/assembly_diagram_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/pdf_text.dart';
import '../../support/plan_helpers.dart';

void main() {
  final everything = AssemblyDiagram(
    caption: 'A caption for the picture',
    width: 100,
    height: 80,
    shapes: [
      for (final t in DiagramTone.values)
        DiagramShape.rect(0, 0, 10, 10, label: 'Z9', tone: t),
      const DiagramShape([
        DiagramPoint(0, 0),
        DiagramPoint(10, 0),
        DiagramPoint(5, 8),
      ], label: 'Long label'),
    ],
    arrows: const [
      DiagramArrow(DiagramPoint(0, 0), DiagramPoint(20, 0)),
      DiagramArrow(DiagramPoint(5, 5), DiagramPoint(5, 5)),
    ],
    marks: const [
      DiagramMark(DiagramPoint(50, 50)),
      DiagramMark(DiagramPoint(60, 50), kind: DiagramMarkKind.nail),
    ],
    dimensions: const [
      DiagramDimension(DiagramPoint(0, 70), DiagramPoint(40, 70), '5 1/2"'),
      DiagramDimension(DiagramPoint(90, 0), DiagramPoint(90, 40), '2"'),
    ],
    pieces: const [
      DiagramPiece('B1', 2, 'outer panel'),
      DiagramPiece('', 6, '1-1/4" screws'),
      DiagramPiece('', 0, 'wood glue'),
    ],
  );

  group('PdfDiagram', () {
    test('draws every part of a diagram without error', () async {
      final bytes = await renderWidgets([PdfDiagram.build(everything)]);
      expect(bytes, isNotEmpty);
    });

    test('writes the caption, labels, measurements and pieces', () async {
      final text = pdfText(await renderWidgets([PdfDiagram.build(everything)]));
      expect(text, contains('caption'));
      expect(text, contains('Z9'));
      expect(text, contains('Long label'));
      expect(text, contains('5 1/2"'));
      expect(text, contains('2x B1 outer panel'));
      expect(text, contains('6x 1-1/4" screws'));
      expect(text, contains('wood glue'));
      expect(text, isNot(contains('0x')));
    });

    test('a diagram with no pieces has no pieces strip', () async {
      final bare = AssemblyDiagram(
        caption: 'Just a caption',
        width: 10,
        height: 10,
        shapes: [DiagramShape.rect(0, 0, 5, 5)],
      );
      final text = pdfText(await renderWidgets([PdfDiagram.build(bare)]));
      expect(text, contains('caption'));
    });

    test('renders every picture in the guide', () async {
      const dg = AssemblyDiagramBuilder();
      final plan = planFor();
      final pictures = [
        dg.cleatPair(plan),
        dg.columnShelf(plan, left: true, k: 0),
        dg.shelfScrews(plan, panelId: 'B1', bandId: 'D1', bandName: 'shelf'),
        dg.barDivider(plan, top: true, k: 0),
        dg.ringColumn(plan, left: true, top: true),
        dg.backs(plan, current: 1),
        dg.mount(plan),
      ];
      final text = pdfText(
        await renderWidgets([for (final d in pictures) PdfDiagram.build(d)]),
      );
      expect(text, contains('Screw placement'));
      expect(text, contains('Side view of the unit hung'));
    });
  });
}
