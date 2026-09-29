import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/services/cleat_layout.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  const layout = CleatLayout();
  final plan = planFor();

  group('CleatLayout', () {
    test('the top row is centered on the top shelf', () {
      expect(layout.shelfFor(plan, 0), plan.leftCol.shelves);
    });

    test('the middle row is centered on the shelf nearest mid-height', () {
      final k = layout.shelfFor(plan, 1)!;
      final d = (layout.shelfCenter(plan, k) - plan.ringH / 2).abs();
      for (var other = 1; other < plan.leftCol.shelves; other++) {
        expect(
          d,
          lessThanOrEqualTo(
            (layout.shelfCenter(plan, other) - plan.ringH / 2).abs(),
          ),
        );
      }
    });

    test('the two rows use different shelves', () {
      expect(layout.shelfFor(plan, 0), isNot(layout.shelfFor(plan, 1)));
    });

    test('a strip is centered on its shelf', () {
      final k = layout.shelfFor(plan, 0)!;
      expect(
        layout.bottomEdge(plan, 0),
        closeTo(layout.shelfCenter(plan, k) - 1.75, 1e-9),
      );
    });

    test('the rows stay inside the unit', () {
      for (var row = 0; row < CleatLayout.rows; row++) {
        expect(layout.bottomEdge(plan, row), greaterThanOrEqualTo(0));
        expect(layout.bottomEdge(plan, row) + 3.5, lessThan(plan.ringH));
      }
    });

    test('with no shelves the top row is flush with the top', () {
      final p = planFor(const Inputs(targetClearH: 80));
      expect(p.leftCol.shelves, 0);
      expect(layout.shelfFor(p, 0), isNull);
      expect(layout.bottomEdge(p, 0), p.ringH - 3.5);
    });

    test('with one shelf the middle row falls back to the bottom', () {
      final p = planFor(const Inputs(targetClearH: 45));
      expect(p.leftCol.shelves, 1);
      expect(layout.shelfFor(p, 1), isNull);
      expect(layout.bottomEdge(p, 1), p.dimensions.kick);
    });

    test('a unit on the floor sits at zero', () {
      expect(layout.unitBottomAboveFloor(plan), 0);
    });

    test('off the floor with no wall the height is unknown', () {
      expect(
        layout.unitBottomAboveFloor(planFor(const Inputs(onFloor: false))),
        isNull,
      );
    });

    test('off the floor with a wall the height comes from the window', () {
      final p = planFor(
        const Inputs(
          onFloor: false,
          wallW: 120,
          wallH: 96,
          windowFromFloor: 40,
        ),
      );
      final h = layout.unitBottomAboveFloor(p)!;
      expect(h, greaterThanOrEqualTo(0));
      expect(h, lessThan(40));
    });
  });
}
