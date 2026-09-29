import 'package:bookshelf_builder/features/planner/domain/models/cost_line.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CostLine', () {
    test('total is quantity times price', () {
      const l = CostLine(label: 'x', quantity: 3, unit: 'sheet', unitPrice: 10);
      expect(l.total, 30);
    });

    test('total is null without a price', () {
      const l = CostLine(
        label: 'x',
        quantity: 3,
        unit: 'sheet',
        unitPrice: null,
      );
      expect(l.total, isNull);
    });

    test('a zero quantity costs nothing', () {
      const l = CostLine(label: 'x', quantity: 0, unit: 'ft', unitPrice: 5);
      expect(l.total, 0);
    });
  });
}
