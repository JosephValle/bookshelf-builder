import 'package:bookshelf_builder/features/planner/domain/models/part.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const plain = Part('Shelf', 3, 12, 11, PartMaterial.ply34);

  group('Part', () {
    test('has no ids until it is labelled', () {
      expect(plain.label, isEmpty);
      expect(plain.ids, isEmpty);
      expect(plain.idRange, isEmpty);
    });

    test('withLabel gives one id per piece, numbered from firstNumber', () {
      final p = plain.withLabel('D', firstNumber: 4);
      expect(p.ids, ['D4', 'D5', 'D6']);
      expect(p.idRange, 'D4-D6');
    });

    test('a single piece shows one id, not a range', () {
      final p = const Part('Top', 1, 76, 11, PartMaterial.ply34).withLabel('A');
      expect(p.ids, ['A1']);
      expect(p.idRange, 'A1');
    });

    test('withLabel keeps every other field', () {
      final p = const Part(
        'Long',
        2,
        48,
        11,
        PartMaterial.ply34,
        splicedFrom: 96,
      ).withLabel('C', firstNumber: 2);
      expect(p.name, 'Long');
      expect(p.qty, 2);
      expect(p.length, 48);
      expect(p.splicedFrom, 96);
    });

    test('label and first number are part of equality', () {
      expect(plain.withLabel('A'), plain.withLabel('A'));
      expect(plain.withLabel('A'), isNot(plain.withLabel('B')));
      expect(plain.withLabel('A'), isNot(plain.withLabel('A', firstNumber: 2)));
    });
  });
}
