import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/severity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  group('Plan', () {
    test('exposes derived dimensions', () {
      final p = planFor();
      expect(p.ringW, 76);
      expect(p.ringH, 76);
      expect(p.kick, 3.5);
      expect(p.spanLimit, 30);
      expect(p.depthPanel, closeTo(11.03125, 1e-9));
      expect(p.sideH, closeTo(71.0625, 1e-9));
    });

    test('errors and warnings filter by severity', () {
      final p = planFor(const Inputs(windowW: 70, left: 8));
      expect(p.errors.every((i) => i.severity == Severity.error), isTrue);
      expect(p.errors, isNotEmpty);
      expect(p.warnings.every((i) => i.severity == Severity.warning), isTrue);
      expect(p.warnings, isNotEmpty);
    });

    test('edgeBandInches is zero without the stiffener', () {
      expect(planFor().edgeBandInches, 0);
    });

    test('edgeBandInches sums every horizontal front edge', () {
      final p = planFor(const Inputs(edgeStiffener: true));
      const expected = 76 * 2 + 48 * 2 + 12.5625 * 12;
      expect(p.edgeBandInches, closeTo(expected, 1e-9));
    });

    test('equal inputs give equal plans', () {
      expect(planFor(), planFor());
    });
  });
}
