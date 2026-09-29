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

    test('parts longer than a sheet are spliced with a note', () {
      final p = planFor(const Inputs(windowH: 96));
      expect(has(p.issues, Severity.note, 'spliced'), isTrue);
    });

    test('a ring wider than the wall is an error without fill', () {
      final p = planFor(const Inputs(wallW: 70, fillWall: false));
      expect(has(p.issues, Severity.error, 'available on the wall'), isTrue);
    });

    test('filling the wall never exceeds the available width', () {
      final p = planFor(const Inputs(wallW: 70));
      expect(has(p.issues, Severity.error, 'available on the wall'), isFalse);
    });

    test('a wall narrower than the window is an error', () {
      final p = planFor(const Inputs(wallW: 40));
      expect(has(p.issues, Severity.error, 'narrower than'), isTrue);
    });

    test('a ring taller than the wall is an error', () {
      final p = planFor(const Inputs(wallH: 70, fillWall: false));
      expect(
        has(p.issues, Severity.error, 'available under the top margin'),
        isTrue,
      );
    });

    test('ceiling clearance under a quarter inch warns', () {
      final p = planFor(const Inputs(wallH: 76.1, fillWall: false));
      expect(
        has(p.issues, Severity.warning, 'Clearance under the top margin'),
        isTrue,
      );
    });

    test('ample ceiling clearance is fine', () {
      expect(planFor(const Inputs(wallH: 96, fillWall: false)).issues, isEmpty);
    });

    test('a window position that pushes the ring off the wall is an error', () {
      final p = planFor(
        const Inputs(wallW: 100, fillWall: false, windowFromWallLeft: 60),
      );
      expect(has(p.issues, Severity.error, 'runs into a wall margin'), isTrue);
    });

    test('a window too close to the left edge is an error', () {
      final p = planFor(
        const Inputs(wallW: 100, fillWall: false, windowFromWallLeft: 5),
      );
      expect(has(p.issues, Severity.error, 'runs into a wall margin'), isTrue);
    });

    test('an uneven ring wider than the wall is an error', () {
      final p = planFor(
        const Inputs(wallW: 80, left: 30, right: 6, fillWall: false),
      );
      expect(has(p.issues, Severity.error, 'available on the wall'), isTrue);
    });

    test('a centered window filling a wide wall is fine', () {
      expect(planFor(const Inputs(wallW: 90)).issues, isEmpty);
    });

    test('a valid window position without fill is fine', () {
      final p = planFor(
        const Inputs(wallW: 100, fillWall: false, windowFromWallLeft: 20),
      );
      expect(p.issues, isEmpty);
    });

    test('filling the wall with a too-small column warns', () {
      final p = planFor(const Inputs(wallW: 100, windowFromWallLeft: 4));
      expect(has(p.issues, Severity.warning, 'minOuterSection'), isTrue);
    });

    test('a top margin reduces the height available', () {
      final p = planFor(
        const Inputs(wallH: 80, wallMarginTop: 6, fillWall: false),
      );
      expect(
        has(p.issues, Severity.error, 'available under the top margin'),
        isTrue,
      );
    });

    test('a top margin that leaves room is fine', () {
      final p = planFor(
        const Inputs(wallH: 96, wallMarginTop: 6, fillWall: false),
      );
      expect(p.issues, isEmpty);
    });

    test('a tight top margin warns about clearance', () {
      final p = planFor(
        const Inputs(wallH: 82, wallMarginTop: 6, fillWall: false),
      );
      expect(
        has(p.issues, Severity.warning, 'Clearance under the top margin'),
        isTrue,
      );
    });

    test('side margins shrink the available width', () {
      final p = planFor(
        const Inputs(wallW: 90, wallMarginLeft: 10, wallMarginRight: 10),
      );
      expect(p.errors, isEmpty);
      expect(p.ringW, 70);
    });

    test('margins that leave less than the window are an error', () {
      final p = planFor(
        const Inputs(wallW: 90, wallMarginLeft: 30, wallMarginRight: 30),
      );
      expect(has(p.issues, Severity.error, 'between the margins'), isTrue);
    });

    test('an unfilled ring cannot run into a margin', () {
      final p = planFor(
        const Inputs(
          wallW: 100,
          fillWall: false,
          wallMarginLeft: 20,
          windowFromWallLeft: 30,
        ),
      );
      expect(has(p.issues, Severity.error, 'runs into a wall margin'), isTrue);
    });

    test('not on the floor adds a support note', () {
      final p = planFor(const Inputs(onFloor: false));
      expect(has(p.issues, Severity.note, 'support plan'), isTrue);
    });
  });

  group('back panels bigger than a sheet', () {
    test('a column wider than a sheet gets a note about joining pieces', () {
      final p = planFor(const Inputs(left: 57));
      expect(has(p.issues, Severity.note, 'Back panel, left column'), isTrue);
      expect(has(p.issues, Severity.note, 'cut in 2 equal pieces'), isTrue);
      expect(has(p.issues, Severity.note, 'backer strip'), isTrue);
    });

    test('it is a note, not a warning about the sheet length', () {
      final p = planFor(const Inputs(left: 57));
      expect(has(p.issues, Severity.warning, 'Back panel'), isFalse);
    });

    test('a normal back has no note', () {
      expect(has(planFor().issues, Severity.note, 'Back panel'), isFalse);
    });
  });
}
