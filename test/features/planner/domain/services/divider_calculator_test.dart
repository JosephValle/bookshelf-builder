import 'package:bookshelf_builder/features/planner/domain/services/divider_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const c = DividerCalculator();

  group('count', () {
    test('no dividers when the run fits the span', () {
      expect(c.count(24, 30), 0);
      expect(c.count(30, 30), 0);
    });

    test('one divider just over the span', () {
      expect(c.count(30.1, 30), 1);
    });

    test('window across a 24 inch box beam', () {
      expect(c.count(48, 24), 1);
    });

    test('window across a 30 inch floor bar', () {
      expect(c.count(48, 30), 1);
    });

    test('wider runs need more dividers', () {
      expect(c.count(120, 24), 4);
    });
  });

  group('bayWidth', () {
    test('is the full run with no dividers', () {
      expect(c.bayWidth(24, 0), 24);
    });

    test('splits the run minus divider thickness', () {
      expect(c.bayWidth(48, 1), closeTo(23.640625, 1e-9));
    });
  });
}
