import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/services/plan_engine.dart';
import 'package:flutter_test/flutter_test.dart';

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

    test('on the floor a 58 inch window needs fewer bottom dividers', () {
      final p = engine.compute(const Inputs(windowW: 58));
      expect(p.bottomBar.dividers, lessThan(p.topBar.dividers + 1));
      expect(p.bottomBar.dividers, 1);
      expect(p.topBar.dividers, 2);
    });

    test('the stiffener widens the span limit and the plan reflects it', () {
      final p = engine.compute(const Inputs(edgeStiffener: true));
      expect(p.spanLimit, 36);
    });
  });
}
