import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  group('GeometryBuilder via the engine', () {
    test('all panels stay inside the ring', () {
      final p = planFor();
      for (final b in p.geometry.panels) {
        expect(b.x, greaterThanOrEqualTo(-1e-9));
        expect(b.y, greaterThanOrEqualTo(-1e-9));
        expect(b.x + b.w, lessThanOrEqualTo(p.ringW + 1e-9));
        expect(b.y + b.h, lessThanOrEqualTo(p.ringH + 1e-9));
      }
    });

    test('no toe kick box when not on the floor', () {
      expect(planFor(const Inputs(onFloor: false)).geometry.toeKickBox, isNull);
    });

    test('a too-narrow column flags its bays bad', () {
      final p = planFor(const Inputs(left: 8));
      expect(p.geometry.bays.any((b) => b.bad), isTrue);
    });

    test('a short shelf opening flags bays bad', () {
      final p = planFor(const Inputs(targetClearH: 6));
      expect(p.geometry.bays.any((b) => b.bad), isTrue);
    });

    test('wide window flags oversize bar bays', () {
      final p = planFor(const Inputs(windowW: 120));
      expect(p.geometry.bays.any((b) => b.bad), isFalse);
    });

    test('two tier bars draw a shelf between tiers', () {
      final one = planFor().geometry.panels.length;
      final two = planFor(const Inputs(top: 20)).geometry.panels.length;
      expect(two, greaterThan(one));
    });

    test('column dividers add panels', () {
      final one = planFor().geometry.panels.length;
      final two = planFor(const Inputs(left: 40)).geometry.panels.length;
      expect(two, greaterThan(one));
    });
  });
}
