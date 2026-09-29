import 'package:bookshelf_builder/features/planner/domain/models/assembly_diagram.dart';
import 'package:bookshelf_builder/features/planner/domain/models/assembly_step.dart';
import 'package:bookshelf_builder/features/planner/domain/models/bar_plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/bay.dart';
import 'package:bookshelf_builder/features/planner/domain/models/box.dart';
import 'package:bookshelf_builder/features/planner/domain/models/column_plan.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_arrow.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_dimension.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_label.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_mark.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_mark_kind.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_piece.dart';
import 'package:bookshelf_builder/features/planner/domain/models/diagram_point.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:bookshelf_builder/features/planner/domain/models/sheet_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Box, Bay, Part, ColumnPlan, BarPlan and SheetPlan have value equality',
    () {
      expect(const Box(1, 2, 3, 4), const Box(1, 2, 3, 4));
      expect(const Box(1, 2, 3, 4), isNot(const Box(1, 2, 3, 5)));
      expect(
        const Bay(Box(0, 0, 1, 1), true),
        const Bay(Box(0, 0, 1, 1), true),
      );
      expect(
        const Part('a', 1, 2, 3, PartMaterial.ply34),
        const Part('a', 1, 2, 3, PartMaterial.ply34),
      );
      expect(
        const ColumnPlan(
          colW: 1,
          clearW: 2,
          shelves: 3,
          clearH: 4,
          dividers: 5,
          bayW: 6,
        ),
        const ColumnPlan(
          colW: 1,
          clearW: 2,
          shelves: 3,
          clearH: 4,
          dividers: 5,
          bayW: 6,
        ),
      );
      expect(
        const BarPlan(
          dividers: 1,
          dividerLength: 2,
          bayW: 3,
          clearH: 4,
          tiers: 1,
        ),
        const BarPlan(
          dividers: 1,
          dividerLength: 2,
          bayW: 3,
          clearH: 4,
          tiers: 1,
        ),
      );
      expect(
        const SheetPlan(
          stripsPerSheet: 4,
          neededStrips: 5,
          sheets34: 2,
          backArea: 10,
          backSheets: 1,
        ),
        const SheetPlan(
          stripsPerSheet: 4,
          neededStrips: 5,
          sheets34: 2,
          backArea: 10,
          backSheets: 1,
        ),
      );
    },
  );

  test('the diagram models have value equality', () {
    const a = AssemblyDiagram(
      caption: 'c',
      width: 1,
      height: 2,
      shapes: [],
      arrows: [DiagramArrow(DiagramPoint(0, 0), DiagramPoint(1, 1))],
      marks: [DiagramMark(DiagramPoint(1, 1))],
      dimensions: [
        DiagramDimension(DiagramPoint(0, 0), DiagramPoint(1, 0), '1"'),
      ],
      pieces: [DiagramPiece('A1', 1, 'top')],
    );
    const b = AssemblyDiagram(
      caption: 'c',
      width: 1,
      height: 2,
      shapes: [],
      arrows: [DiagramArrow(DiagramPoint(0, 0), DiagramPoint(1, 1))],
      marks: [DiagramMark(DiagramPoint(1, 1))],
      dimensions: [
        DiagramDimension(DiagramPoint(0, 0), DiagramPoint(1, 0), '1"'),
      ],
      pieces: [DiagramPiece('A1', 1, 'top')],
    );
    expect(a, b);
    expect(a.withPieces(const []), isNot(b));
    expect(a.withPieces(const []).caption, 'c');
    expect(
      const DiagramMark(DiagramPoint(1, 1)),
      isNot(const DiagramMark(DiagramPoint(1, 1), kind: DiagramMarkKind.nail)),
    );
    expect(
      const AssemblyStep('t', ['d'], diagrams: [a]),
      const AssemblyStep('t', ['d'], diagrams: [b]),
    );
    expect(const AssemblyStep('t', ['d']).diagrams, isEmpty);
  });

  test('labels, copies and step extras compare by value', () {
    expect(
      const DiagramLabel(DiagramPoint(1, 2), 'D1'),
      const DiagramLabel(DiagramPoint(1, 2), 'D1'),
    );
    expect(
      const DiagramLabel(DiagramPoint(1, 2), 'D1'),
      isNot(const DiagramLabel(DiagramPoint(1, 2), 'D2')),
    );
    const d = AssemblyDiagram(
      caption: 'c',
      width: 1,
      height: 1,
      shapes: [],
      labels: [DiagramLabel(DiagramPoint(0, 0), 'A1')],
    );
    final copy = d.copyWith(caption: 'new', large: true);
    expect(copy.caption, 'new');
    expect(copy.large, isTrue);
    expect(copy.labels, d.labels);
    expect(d.copyWith(), d);
    const a = AssemblyStep('t', ['d'], tools: ['saw: cuts']);
    expect(a, const AssemblyStep('t', ['d'], tools: ['saw: cuts']));
    expect(a, isNot(const AssemblyStep('t', ['d'])));
    expect(
      const AssemblyStep('t', ['d'], hardware: ['1 x screw']),
      isNot(const AssemblyStep('t', ['d'])),
    );
    expect(const AssemblyStep('t', ['d'], checkpoint: true).checkpoint, isTrue);
    expect(const AssemblyStep('t', ['d']).checkpoint, isFalse);
  });

  test('a dimension is dark by default and compares by value', () {
    const a = DiagramDimension(DiagramPoint(0, 0), DiagramPoint(1, 0), '1"');
    expect(a.light, isFalse);
    expect(
      a,
      const DiagramDimension(DiagramPoint(0, 0), DiagramPoint(1, 0), '1"'),
    );
    expect(
      a,
      isNot(
        const DiagramDimension(
          DiagramPoint(0, 0),
          DiagramPoint(1, 0),
          '1"',
          light: true,
        ),
      ),
    );
  });
}
