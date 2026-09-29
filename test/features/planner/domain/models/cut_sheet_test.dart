import 'package:bookshelf_builder/features/planner/domain/models/cut_sheet.dart';
import 'package:bookshelf_builder/features/planner/domain/models/layout_piece.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const a = LayoutPiece(
    id: 'A1',
    name: 'Top',
    x: 0,
    y: 0,
    length: 40,
    width: 11,
  );
  const b = LayoutPiece(
    id: 'B1',
    name: 'Shelf',
    x: 40.125,
    y: 0,
    length: 12,
    width: 11,
  );
  const c = LayoutPiece(
    id: 'C1',
    name: 'Kick',
    x: 0,
    y: 11.125,
    length: 50,
    width: 3.5,
  );
  const sheet = CutSheet(
    material: PartMaterial.ply34,
    number: 1,
    pieces: [b, c, a],
  );

  group('CutSheet', () {
    test('lists each strip top once, from the top edge down', () {
      expect(sheet.stripTops, [0, 11.125]);
    });

    test('a strip is left to right regardless of the order given', () {
      expect(sheet.strip(0).map((p) => p.id), ['A1', 'B1']);
    });

    test('a strip is as wide as its widest piece', () {
      expect(sheet.stripWidth(0), 11);
      expect(sheet.stripWidth(11.125), 3.5);
    });

    test('rip marks are the finished lower edge of every strip', () {
      expect(sheet.ripMarks, [11, 14.625]);
    });

    test('has value equality', () {
      expect(
        sheet,
        const CutSheet(
          material: PartMaterial.ply34,
          number: 1,
          pieces: [b, c, a],
        ),
      );
      expect(sheet, isNot(sheet.copyWith(number: 2)));
      expect(a, isNot(b));
    });
  });
}
