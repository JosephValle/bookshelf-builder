import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PartMaterial', () {
    test('has display labels', () {
      expect(PartMaterial.ply34.label, '3/4" plywood');
      expect(PartMaterial.ply14.label, '1/4" plywood');
      expect(PartMaterial.edgeBand.label, 'edge band');
    });
  });
}
