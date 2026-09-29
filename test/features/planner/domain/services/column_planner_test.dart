import 'package:bookshelf_builder/features/planner/domain/models/dimensions.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/services/column_planner.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const planner = ColumnPlanner();

  ({Inputs i, Dimensions d}) setup(Inputs i) => (i: i, d: Dimensions.from(i));

  group('plan', () {
    test('default column has six shelves at about 9.5357 clear', () {
      final s = setup(const Inputs());
      final c = planner.plan(14, s.i, s.d);
      expect(c.shelves, 6);
      expect(c.clearH, closeTo(9.5357, 1e-3));
      expect(c.clearW, closeTo(12.5625, 1e-9));
      expect(c.dividers, 0);
    });

    test('clear height times openings plus shelves equals side height', () {
      final s = setup(const Inputs());
      final c = planner.plan(14, s.i, s.d);
      expect(
        c.clearH * (c.shelves + 1) + c.shelves * 0.71875,
        closeTo(s.d.sideH, 1e-9),
      );
    });

    test('a wide column gets dividers', () {
      final s = setup(const Inputs(left: 40));
      final c = planner.plan(40, s.i, s.d);
      expect(c.clearW, closeTo(38.5625, 1e-9));
      expect(c.dividers, 1);
      expect(c.bayW, closeTo((38.5625 - 0.71875) / 2, 1e-9));
    });

    test('the stiffener lets a wider shelf width skip dividers', () {
      const wide = Inputs(left: 34, maxShelfWidth: 36);
      final bare = setup(wide);
      final stiff = setup(wide.copyWith(edgeStiffener: true));
      expect(planner.plan(34, bare.i, bare.d).dividers, 1);
      expect(planner.plan(34, stiff.i, stiff.d).dividers, 0);
    });

    test('the preferred shelf width adds dividers before the limit does', () {
      final narrow = setup(const Inputs(left: 30, maxShelfWidth: 16));
      final c = planner.plan(30, narrow.i, narrow.d);
      expect(c.clearW, closeTo(28.5625, 1e-9));
      expect(c.dividers, 1);
      expect(c.bayW, lessThanOrEqualTo(16));
    });

    test('a bay is never wider than the preferred shelf width', () {
      for (final w in [16.0, 20.0, 24.0]) {
        final s = setup(Inputs(left: 50, maxShelfWidth: w));
        final c = planner.plan(50, s.i, s.d);
        expect(c.bayW, lessThanOrEqualTo(w + 1e-9), reason: 'width $w');
      }
    });

    test('the structural limit caps a generous shelf width', () {
      final s = setup(const Inputs(left: 40, maxShelfWidth: 36));
      final c = planner.plan(40, s.i, s.d);
      expect(c.bayW, lessThanOrEqualTo(30));
    });

    test('a ring shorter than the target needs no fixed shelves', () {
      final s = setup(const Inputs(targetClearH: 80));
      final c = planner.plan(14, s.i, s.d);
      expect(c.shelves, 0);
      expect(c.clearH, closeTo(s.d.sideH, 1e-9));
    });

    test('a short ring gets fewer shelves', () {
      final s = setup(const Inputs(windowH: 12, top: 9.5, bottom: 9.5));
      expect(planner.plan(14, s.i, s.d).shelves, 2);
    });
  });
}
