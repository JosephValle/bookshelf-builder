import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Limits', () {
    test('plywood thicknesses match nominal 3/4 and 1/4 sheets', () {
      expect(Limits.t, 23 / 32);
      expect(Limits.backT, 7 / 32);
    });

    test('minOuterSection is minClearW plus two panels', () {
      expect(Limits.minOuterSection, Limits.minClearW + 2 * Limits.t);
    });

    test('stiffened span is longer than the bare span', () {
      expect(Limits.maxShelfSpanStiffened, greaterThan(Limits.maxShelfSpan));
    });

    test('the anchor cleat is 3-1/2 inches wide', () {
      expect(Limits.anchorCleatW, 3.5);
    });

    test('sheet is 4 by 8 feet', () {
      expect(Limits.sheetW, 48);
      expect(Limits.sheetL, 96);
    });
  });
}
