import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/services/plan_engine.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  const engine = PlanEngine();

  group('compute', () {
    test('derived defaults', () {
      final p = engine.compute(const Inputs());
      expect(p.ringW, 76);
      expect(p.ringH, 76);
      expect(p.depthPanel, closeTo(11.03125, 1e-9));
      expect(p.sideH, closeTo(71.0625, 1e-9));
    });

    test('default columns', () {
      final p = engine.compute(const Inputs());
      expect(p.leftCol.shelves, 6);
      expect(p.rightCol.shelves, 6);
      expect(p.leftCol.clearH, closeTo(9.5357, 1e-3));
    });

    test('default top bar', () {
      final b = engine.compute(const Inputs()).topBar;
      expect(b.dividers, 1);
      expect(b.dividerLength, closeTo(12.5625, 1e-9));
      expect(b.bayW, closeTo(23.640625, 1e-9));
      expect(b.tiers, 1);
    });

    test('default bottom bar', () {
      final b = engine.compute(const Inputs()).bottomBar;
      expect(b.dividers, 1);
      expect(b.dividerLength, closeTo(9.0625, 1e-9));
      expect(b.bayW, closeTo(23.640625, 1e-9));
      expect(b.tiers, 1);
    });

    test('default inputs have no errors', () {
      expect(engine.compute(const Inputs()).errors, isEmpty);
    });

    test('is deterministic', () {
      expect(engine.compute(const Inputs()), engine.compute(const Inputs()));
    });

    test('off the floor the bottom bar uses the box beam spacing', () {
      const i = Inputs(onFloor: false, windowW: 58);
      final p = engine.compute(i);
      expect(p.bottomBar.dividers, engine.compute(i).topBar.dividers);
    });

    test('on the floor the bottom bar can use the wider shelf span', () {
      final p = planFor(const Inputs(windowW: 58, maxShelfWidth: 30));
      expect(p.bottomBar.dividers, 1);
      expect(p.topBar.dividers, 2);
    });

    test('the preferred shelf width narrows the bottom bar bays', () {
      final wide = planFor(const Inputs(windowW: 58, maxShelfWidth: 30));
      final narrow = planFor(const Inputs(windowW: 58));
      expect(narrow.bottomBar.bayW, lessThan(wide.bottomBar.bayW));
    });

    test('the top bar never exceeds the box beam spacing', () {
      final p = planFor(const Inputs(windowW: 58, maxShelfWidth: 36));
      expect(p.topBar.bayW, lessThanOrEqualTo(24));
    });

    test('a wall width grows the columns to fill it', () {
      final p = planFor(const Inputs(wallW: 90));
      expect(p.ringW, 90);
      expect(p.leftCol.colW, 21);
      expect(p.rightCol.colW, 21);
    });

    test('a moved window makes uneven columns', () {
      final p = planFor(const Inputs(wallW: 90, windowFromWallLeft: 10));
      expect(p.ringW, 90);
      expect(p.leftCol.colW, 10);
      expect(p.rightCol.colW, 32);
    });

    test('margins keep the ring inside the usable wall', () {
      final p = planFor(
        const Inputs(wallW: 100, wallMarginLeft: 6, wallMarginRight: 10),
      );
      expect(p.ringW, 84);
      expect(p.ringOffsetOnWall, 6);
    });

    test('without fill the columns keep their width', () {
      final p = planFor(const Inputs(wallW: 90, fillWall: false));
      expect(p.ringW, 76);
    });

    test('wide columns from a big wall get dividers', () {
      final p = planFor(const Inputs(wallW: 90));
      expect(p.leftCol.dividers, 0);
      final wider = planFor(const Inputs(wallW: 96, windowFromWallLeft: 40));
      expect(wider.leftCol.dividers, greaterThan(0));
    });

    test('the plan keeps the resolved inputs for drawing', () {
      final p = planFor(const Inputs(wallW: 90));
      expect(p.inputs.left, 21);
    });

    test('the stiffener widens the span limit and the plan reflects it', () {
      final p = engine.compute(const Inputs(edgeStiffener: true));
      expect(p.spanLimit, 36);
    });
  });
}
