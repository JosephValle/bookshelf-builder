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

  group('panel names', () {
    test('every panel has a name', () {
      final g = planFor().geometry;
      expect(g.panelNames.length, g.panels.length);
    });

    test('the four long panels come first, then the column panels', () {
      final names = planFor().geometry.panelNames;
      expect(names.take(4), [
        'Top panel',
        'Bottom panel',
        'Head panel',
        'Sill panel',
      ]);
      expect(names.skip(4).take(4), [
        'Outer column panel',
        'Inner column panel',
        'Inner column panel',
        'Outer column panel',
      ]);
    });

    test('shelves and dividers are named for their column or bar', () {
      final p = planFor(const Inputs(left: 40, top: 20));
      final names = p.geometry.panelNames;
      expect(
        names.where((n) => n == 'Left column shelf').length,
        p.leftCol.shelves,
      );
      expect(
        names.where((n) => n == 'Right column shelf').length,
        p.rightCol.shelves,
      );
      expect(
        names.where((n) => n == 'Top bar divider').length,
        p.topBar.dividers,
      );
      expect(names.where((n) => n == 'Top bar shelf').isNotEmpty, isTrue);
    });

    test('every name is a part in the cut list with a matching count', () {
      // Kept under one sheet length so no part is spliced into two pieces.
      final p = planFor(const Inputs(left: 30, top: 20, bottom: 20));
      final counts = <String, int>{};
      for (final n in p.geometry.panelNames) {
        counts[n] = (counts[n] ?? 0) + 1;
      }
      for (final e in counts.entries) {
        final part = p.parts.firstWhere((x) => x.name == e.key);
        expect(part.qty, e.value, reason: e.key);
      }
    });
  });
}
