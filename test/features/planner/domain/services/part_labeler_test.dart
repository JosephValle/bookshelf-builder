import 'package:bookshelf_builder/features/planner/domain/models/part.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:bookshelf_builder/features/planner/domain/services/part_labeler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const labeler = PartLabeler();

  group('labelFor', () {
    test('runs A to Z without I and O', () {
      expect(PartLabeler.labelFor(0), 'A');
      expect(PartLabeler.labelFor(7), 'H');
      expect(PartLabeler.labelFor(8), 'J');
      expect(PartLabeler.labelFor(23), 'Z');
      final singles = [for (var k = 0; k < 24; k++) PartLabeler.labelFor(k)];
      expect(singles, isNot(contains('I')));
      expect(singles, isNot(contains('O')));
    });

    test('continues with two letters after Z', () {
      expect(PartLabeler.labelFor(24), 'AA');
      expect(PartLabeler.labelFor(25), 'AB');
      expect(PartLabeler.labelFor(48), 'BA');
    });
  });

  group('label', () {
    test('parts with the same material and size share a letter', () {
      final out = labeler.label(const [
        Part('Top panel', 1, 76, 11, PartMaterial.ply34),
        Part('Shelf', 6, 12, 11, PartMaterial.ply34),
        Part('Bottom panel', 1, 76, 11, PartMaterial.ply34),
      ]);
      expect(out[0].label, 'A');
      expect(out[1].label, 'B');
      expect(out[2].label, 'A');
    });

    test('pieces are numbered per letter across lines', () {
      final out = labeler.label(const [
        Part('Top panel', 1, 76, 11, PartMaterial.ply34),
        Part('Shelf', 6, 12, 11, PartMaterial.ply34),
        Part('Bottom panel', 1, 76, 11, PartMaterial.ply34),
      ]);
      expect(out[0].ids, ['A1']);
      expect(out[1].ids, ['B1', 'B2', 'B3', 'B4', 'B5', 'B6']);
      expect(out[2].ids, ['A2']);
    });

    test('a different width or material is a different piece', () {
      final out = labeler.label(const [
        Part('One', 1, 10, 5, PartMaterial.ply34),
        Part('Wider', 1, 10, 6, PartMaterial.ply34),
        Part('Thinner', 1, 10, 5, PartMaterial.ply14),
      ]);
      expect({for (final p in out) p.label}.length, 3);
    });

    test('sizes within a thousandth of an inch count as equal', () {
      final out = labeler.label(const [
        Part('One', 1, 10, 5, PartMaterial.ply34),
        Part('Two', 1, 10.0001, 5, PartMaterial.ply34),
      ]);
      expect(out[0].label, out[1].label);
    });

    test('an empty list stays empty', () {
      expect(labeler.label(const []), isEmpty);
    });
  });
}
