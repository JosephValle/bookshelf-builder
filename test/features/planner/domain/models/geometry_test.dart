import 'package:bookshelf_builder/features/planner/domain/models/box.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
import 'package:bookshelf_builder/features/planner/domain/models/plan.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  group('Geometry from the default plan', () {
    final g = planFor().geometry;

    test('window sits at the column and top bar offsets', () {
      expect(g.windowBox.x, 14);
      expect(g.windowBox.y, 14);
      expect(g.windowBox.w, 48);
      expect(g.windowBox.h, 48);
    });

    test('toe kick fills the bottom 3.5 inches', () {
      expect(g.toeKickBox!.y, 72.5);
      expect(g.toeKickBox!.h, 3.5);
      expect(g.toeKickBox!.w, 76);
    });

    test('every panel is a true 3/4 inch thick', () {
      final thin = g.panels.where(
        (p) => (p.w - Limits.t).abs() < 1e-9 || (p.h - Limits.t).abs() < 1e-9,
      );
      expect(thin.length, g.panels.length);
    });

    test('bay count is 14 column bays plus 4 bar bays', () {
      expect(g.bays.length, 7 * 2 + 2 + 2);
    });

    test('no default bay is flagged bad', () {
      expect(g.bays.where((b) => b.bad), isEmpty);
    });
  });

  group('window, trim and opening boxes', () {
    test('without trim or gaps all three match', () {
      final g = planFor().geometry;
      expect(g.windowBox, g.openingBox);
      expect(g.trimBox, g.openingBox);
    });

    test('the window sits inside the trim which sits inside the opening', () {
      final g = planFor(
        const Inputs(
          trimTop: 2,
          trimBottom: 3,
          trimLeft: 1,
          trimRight: 1,
          gapTop: 1,
          gapBottom: 1,
          gapLeft: 2,
          gapRight: 2,
        ),
      ).geometry;
      expect(g.openingBox, const Box(14, 14, 54, 55));
      expect(g.trimBox, const Box(16, 15, 50, 53));
      expect(g.windowBox, const Box(17, 17, 48, 48));
    });

    test('the window is centered when trim is even', () {
      final g = planFor(const Inputs(trimLeft: 2, trimRight: 2)).geometry;
      expect(g.windowBox.x - g.openingBox.x, 2);
      expect(
        g.openingBox.x + g.openingBox.w - (g.windowBox.x + g.windowBox.w),
        2,
      );
    });
  });

  group('plywood thickness is accounted for everywhere', () {
    double area(Box b) => b.w * b.h;

    double covered(Plan p) {
      final g = p.geometry;
      var a = g.panels.fold<double>(0, (sum, b) => sum + area(b));
      a += g.bays.fold<double>(0, (sum, b) => sum + area(b.box));
      a += area(g.openingBox);
      if (g.toeKickBox != null) a += area(g.toeKickBox!);
      return a;
    }

    final scenarios = <String, Inputs>{
      'defaults': const Inputs(),
      'off the floor': const Inputs(onFloor: false),
      'tall bars with tiers': const Inputs(top: 22, bottom: 24),
      'wide columns with dividers': const Inputs(left: 40, right: 34),
      'narrow shelf width': const Inputs(maxShelfWidth: 14, windowW: 58),
      'gaps and trim': const Inputs(
        trimTop: 2,
        trimLeft: 3,
        trimRight: 3,
        trimBottom: 2,
        gapTop: 1,
        gapBottom: 1,
        gapLeft: 0.5,
        gapRight: 0.5,
      ),
      'filled wall': const Inputs(
        wallW: 120,
        wallH: 96,
        wallMarginLeft: 6,
        wallMarginTop: 4,
      ),
      'stiffener': const Inputs(edgeStiffener: true, left: 34),
      'odd sizes': const Inputs(
        windowW: 41.3125,
        windowH: 37.5,
        left: 17.75,
        right: 12.125,
        targetClearH: 9,
      ),
    };

    for (final e in scenarios.entries) {
      test('panels, bays, opening and toe kick tile the ring: ${e.key}', () {
        final p = planFor(e.value);
        expect(covered(p), closeTo(p.ringW * p.ringH, 1e-6));
      });
    }

    test('each column stacks to the full height', () {
      final p = planFor();
      const t = Limits.t;
      final c = p.leftCol;
      final stack = t + (c.shelves + 1) * c.clearH + c.shelves * t + t + p.kick;
      expect(stack, closeTo(p.ringH, 1e-9));
    });

    test('a column plus its two panels is the column width', () {
      final p = planFor(const Inputs(left: 40));
      const t = Limits.t;
      final c = p.leftCol;
      final across = 2 * t + (c.dividers + 1) * c.bayW + c.dividers * t;
      expect(across, closeTo(c.colW, 1e-9));
    });

    test('a bar stacks to its full height', () {
      final p = planFor(const Inputs(top: 22, bottom: 24));
      const t = Limits.t;
      final b = p.topBar;
      expect(2 * t + b.clearH, closeTo(22, 1e-9));
      expect(p.bottomBar.clearH + 2 * t + p.kick, closeTo(24, 1e-9));
    });

    test('bar bays plus dividers span the opening exactly', () {
      final p = planFor(const Inputs(windowW: 58));
      const t = Limits.t;
      final b = p.topBar;
      expect((b.dividers + 1) * b.bayW + b.dividers * t, closeTo(58, 1e-9));
    });

    test('ring width is columns plus the opening', () {
      final p = planFor(const Inputs(trimLeft: 2, gapRight: 1));
      expect(p.ringW, 14 + 48 + 2 + 1 + 14);
    });
  });
}
