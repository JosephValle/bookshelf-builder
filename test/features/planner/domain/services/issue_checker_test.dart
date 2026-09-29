import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/issue.dart';
import 'package:bookshelf_builder/features/planner/domain/models/severity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  bool has(List<Issue> issues, Severity s, String text) =>
      issues.any((i) => i.severity == s && i.message.contains(text));

  group('IssueChecker via the engine', () {
    test('defaults have no issues', () {
      expect(planFor().issues, isEmpty);
    });

    test('window over 60 inches is an error', () {
      final p = planFor(const Inputs(windowW: 70));
      expect(has(p.issues, Severity.error, 'maxWindowSpan'), isTrue);
    });

    test('window at 60 inches is fine', () {
      expect(planFor(const Inputs(windowW: 60)).errors, isEmpty);
    });

    test('narrow columns and bars warn with minOuterSection', () {
      for (final i in [
        const Inputs(left: 8),
        const Inputs(right: 8),
        const Inputs(top: 8),
      ]) {
        expect(
          has(planFor(i).issues, Severity.warning, 'minOuterSection'),
          isTrue,
        );
      }
    });

    test('bottom bar minimum includes the toe kick', () {
      expect(
        has(
          planFor(const Inputs(bottom: 12)).issues,
          Severity.warning,
          'Bottom bar',
        ),
        isTrue,
      );
      expect(
        has(
          planFor(const Inputs(bottom: 12, onFloor: false)).issues,
          Severity.warning,
          'Bottom bar',
        ),
        isFalse,
      );
    });

    test('depth outside the range warns', () {
      expect(
        has(planFor(const Inputs(depth: 7)).issues, Severity.warning, 'Depth'),
        isTrue,
      );
      expect(
        has(planFor(const Inputs(depth: 17)).issues, Severity.warning, 'Depth'),
        isTrue,
      );
    });

    test('short shelf openings warn about clear height', () {
      final p = planFor(const Inputs(targetClearH: 6));
      expect(has(p.issues, Severity.warning, 'minimum clear height'), isTrue);
    });

    test('narrow bays warn about clear width', () {
      final p = planFor(const Inputs(left: 9));
      expect(has(p.issues, Severity.warning, 'minimum clear width'), isTrue);
    });

    test('parts longer than a sheet warn', () {
      final p = planFor(const Inputs(windowH: 96));
      expect(has(p.issues, Severity.warning, 'spliced'), isTrue);
    });

    test('a ring wider than the wall is an error', () {
      final p = planFor(const Inputs(wallW: 70));
      expect(has(p.issues, Severity.error, 'wall width'), isTrue);
    });

    test('a ring taller than the wall is an error', () {
      final p = planFor(const Inputs(wallH: 70));
      expect(has(p.issues, Severity.error, 'wall height'), isTrue);
    });

    test('ceiling clearance under a quarter inch warns', () {
      final p = planFor(const Inputs(wallH: 76.1));
      expect(has(p.issues, Severity.warning, 'Ceiling clearance'), isTrue);
    });

    test('ample ceiling clearance is fine', () {
      expect(planFor(const Inputs(wallH: 96)).issues, isEmpty);
    });

    test('an offset that pushes the ring off the wall is an error', () {
      final p = planFor(const Inputs(wallW: 100, ringOffsetFromLeft: 30));
      expect(has(p.issues, Severity.error, 'does not fit'), isTrue);
    });

    test('a negative offset is an error', () {
      final p = planFor(const Inputs(wallW: 100, ringOffsetFromLeft: -1));
      expect(has(p.issues, Severity.error, 'does not fit'), isTrue);
    });

    test('centering the window can push an uneven ring off the wall', () {
      final p = planFor(const Inputs(wallW: 80, left: 30, right: 6));
      expect(has(p.issues, Severity.error, 'does not fit'), isTrue);
    });

    test('a centered window on a wide wall is fine', () {
      expect(planFor(const Inputs(wallW: 120)).issues, isEmpty);
    });

    test('a valid offset is fine', () {
      final p = planFor(const Inputs(wallW: 100, ringOffsetFromLeft: 12));
      expect(p.issues, isEmpty);
    });

    test('not on the floor adds a support note', () {
      final p = planFor(const Inputs(onFloor: false));
      expect(has(p.issues, Severity.note, 'support plan'), isTrue);
    });
  });
}
