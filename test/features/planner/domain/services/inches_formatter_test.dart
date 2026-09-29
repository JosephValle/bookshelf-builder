import 'package:bookshelf_builder/features/planner/domain/models/part.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:bookshelf_builder/features/planner/domain/services/inches_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const f = InchesFormatter();

  group('format', () {
    test('whole numbers', () => expect(f.format(12), '12"'));
    test('zero', () => expect(f.format(0), '0"'));
    test('mixed fractions', () => expect(f.format(11.25), '11 1/4"'));
    test('fraction only', () => expect(f.format(0.5), '1/2"'));
    test('reduces to lowest terms', () => expect(f.format(2.375), '2 3/8"'));
    test('keeps sixteenths', () => expect(f.format(0.0625), '1/16"'));
    test('rounds to the nearest sixteenth', () {
      expect(f.format(11.03125), '11 1/16"');
      expect(f.format(11.04), '11 1/16"');
    });
    test('carries when rounding up to a whole', () {
      expect(f.format(9.99), '10"');
    });
    test('negative values', () => expect(f.format(-1.5), '-1 1/2"'));
    test('tiny negative rounds to zero without a sign', () {
      expect(f.format(-0.001), '0"');
    });
  });

  group('plain', () {
    test('omits the inch mark', () => expect(f.plain(11.25), '11 1/4'));
  });

  group('partLength', () {
    test('formats inches for lumber parts', () {
      const p = Part('a', 1, 12.5625, 11, PartMaterial.ply34);
      expect(f.partLength(p), '12 9/16"');
    });

    test('formats feet for edge band', () {
      const p = Part('e', 1, 240, 0, PartMaterial.edgeBand);
      expect(f.partLength(p), '20.0 ft');
    });
  });
}
