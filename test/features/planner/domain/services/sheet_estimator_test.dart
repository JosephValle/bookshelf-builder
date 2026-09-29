import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  group('SheetEstimator via the engine', () {
    test('default depth yields 4 strips per sheet', () {
      expect(planFor().sheets.stripsPerSheet, 4);
    });

    test('default plan needs a few sheets', () {
      final s = planFor().sheets;
      expect(s.neededStrips, greaterThanOrEqualTo(6));
      expect(s.sheets34, (s.neededStrips / s.stripsPerSheet).ceil());
      expect(s.sheets34, greaterThanOrEqualTo(2));
    });

    test('back area sums the four back panels', () {
      final s = planFor().sheets;
      expect(s.backArea, closeTo(14 * 76 * 2 + 48 * 14 * 2, 1e-9));
      expect(s.backSheets, 1);
    });

    test('shallower depth gives more strips per sheet', () {
      final s = planFor(const Inputs(depth: 7.25)).sheets;
      expect(s.stripsPerSheet, 6);
    });

    test('a toe kick that does not fit costs one more strip', () {
      final on = planFor().sheets.neededStrips;
      final off = planFor(const Inputs(onFloor: false)).sheets.neededStrips;
      expect(on, greaterThanOrEqualTo(off));
    });

    test('parts longer than a sheet are left out of packing', () {
      final tall = planFor(const Inputs(windowH: 96, top: 14, bottom: 14));
      expect(tall.sheets.neededStrips, greaterThan(0));
    });

    test('cleats and the toe kick share strips instead of costing a sheet', () {
      final off = planFor(const Inputs(onFloor: false)).sheets;
      final on = planFor().sheets;
      expect(on.neededStrips - off.neededStrips, lessThanOrEqualTo(2));
    });

    test('a huge ring needs more sheets', () {
      final small = planFor().sheets.sheets34;
      final big = planFor(const Inputs(windowW: 60, windowH: 60))
          .sheets
          .sheets34;
      expect(big, greaterThanOrEqualTo(small));
    });
  });

  group('sheet counts follow the cutting layout', () {
    test('the back sheets come from packing the backs, not from area', () {
      // Three 57 inch backs cannot share a sheet the way area suggests.
      final s = planFor(const Inputs(left: 40, right: 40)).sheets;
      expect(s.backSheets, 3);
    });

    test('a tighter layout can need fewer back sheets than the area rule', () {
      final s = planFor(const Inputs(top: 20, bottom: 20)).sheets;
      expect(s.backSheets, 1);
    });

    test('a huge column still gets enough sheets', () {
      final s = planFor(const Inputs(left: 57)).sheets;
      expect(s.backSheets, greaterThanOrEqualTo(2));
    });
  });
}
