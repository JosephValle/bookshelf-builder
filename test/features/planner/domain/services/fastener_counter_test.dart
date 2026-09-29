import 'package:bookshelf_builder/features/planner/domain/models/fasteners.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/services/fastener_counter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  const counter = FastenerCounter();
  final plan = planFor();
  final perJoint = Fasteners.screwsPerJoint(plan.depthPanel);

  group('FastenerCounter', () {
    test('a column takes screws for both ends of every shelf', () {
      expect(
        counter.columnScrews(plan, plan.leftCol),
        plan.leftCol.shelves * 2 * perJoint,
      );
    });

    test('dividers in a column add screws at both ends', () {
      final p = planFor(const Inputs(left: 40));
      final c = p.leftCol;
      expect(c.dividers, greaterThan(0));
      expect(
        counter.columnScrews(p, c),
        (c.shelves * 2 + c.dividers * (c.shelves + 1) * 2) *
            Fasteners.screwsPerJoint(p.depthPanel),
      );
    });

    test('a bar takes screws at both ends of every divider', () {
      final b = plan.topBar;
      expect(counter.barScrews(plan, b), b.dividers * 2 * perJoint);
    });

    test('a two tier bar adds the middle shelf ends', () {
      final p = planFor(const Inputs(top: 20));
      final b = p.topBar;
      expect(b.tiers, 2);
      expect(
        counter.barScrews(p, b),
        (b.dividers * 2 + (b.dividers + 1) * 2) *
            Fasteners.screwsPerJoint(p.depthPanel),
      );
    });

    test('the ring joints are twelve per joint plus outer dividers', () {
      expect(counter.ringScrews(plan), 12 * perJoint);
      final p = planFor(const Inputs(left: 40));
      expect(
        counter.ringScrews(p),
        (12 + (p.leftCol.dividers + p.rightCol.dividers) * 2) *
            Fasteners.screwsPerJoint(p.depthPanel),
      );
    });

    test('the toe kick is screwed about every 8 inches', () {
      expect(counter.toeKickScrews(plan), (plan.ringW / 8).ceil());
    });

    test('brads cover every edge and everything behind the backs', () {
      final count = counter.backBrads(plan);
      expect(count, greaterThan(100));
      final withBand = counter.backBrads(planFor(const Inputs(top: 20)));
      expect(withBand, greaterThan(count));
    });

    test('there are four cleat pieces, two per column', () {
      expect(counter.cleatPieceLengths(plan), [14, 14, 14, 14]);
    });

    test('unit cleat screws start 1 inch in and repeat every 6', () {
      // 14 in: (14 - 2) / 6 = 2 gaps, so 3 screws per piece.
      expect(counter.pieceScrews(plan, 0, wall: false), 3);
      expect(counter.unitCleatScrews(plan), 12);
    });

    test('wall cleat screws are two per stud, at least one stud a piece', () {
      expect(counter.pieceScrews(plan, 0, wall: true), 2);
      expect(counter.wallCleatScrews(plan), 8);
      final wide = planFor(const Inputs(left: 40, right: 40));
      expect(counter.pieceScrews(wide, 0, wall: true), 6);
    });
  });

  group('wall screws by wall type', () {
    test('stud spacing sets how many studs a piece crosses', () {
      final wide = planFor(const Inputs(left: 40, right: 40));
      // 40 in / 16 in = 3 studs, 40 in / 24 in = 2 studs.
      expect(counter.pieceScrews(wide, 0, wall: true), 6);
      final far = planFor(const Inputs(left: 40, right: 40, studSpacing: 24));
      expect(counter.pieceScrews(far, 0, wall: true), 4);
    });

    test('concrete uses pairs 1.5 in from the ends and every 12 in', () {
      final p = planFor(const Inputs(concreteWall: true));
      // 14 in: (14 - 3) / 12 = 1 gap, so 2 pairs = 4 screws.
      expect(counter.pieceScrews(p, 0, wall: true), 4);
      expect(counter.wallCleatScrews(p), 16);
    });

    test('a longer concrete piece gets more pairs', () {
      final p = planFor(const Inputs(concreteWall: true, left: 40, right: 40));
      // 40 in: (40 - 3) / 12 = 4 gaps, so 5 pairs = 10 screws.
      expect(counter.pieceScrews(p, 0, wall: true), 10);
    });
  });
}
