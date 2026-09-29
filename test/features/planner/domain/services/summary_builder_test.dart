import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/planner_notes.dart';
import 'package:bookshelf_builder/features/planner/domain/services/summary_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  const builder = SummaryBuilder();

  group('build', () {
    test('states the ring size', () {
      expect(builder.build(planFor()), contains('Ring: 76" wide by 76" tall'));
    });

    test('lists the cut list and sheet counts', () {
      final text = builder.build(planFor());
      expect(text, contains('Cut list'));
      expect(text, contains('A1: 1 x Top panel'));
      expect(text, contains('3/4" plywood sheets:'));
      expect(text, contains('1/4" plywood sheets: 1 (approximate)'));
    });

    test('ends with the store note and disclaimer', () {
      final text = builder.build(planFor());
      expect(text, contains(PlannerNotes.store));
      expect(text, contains(PlannerNotes.disclaimer));
    });

    test('omits the warnings section when there are none', () {
      expect(builder.build(planFor()), isNot(contains('Warnings')));
    });

    test('lists warnings when present', () {
      final text = builder.build(planFor(const Inputs(left: 8)));
      expect(text, contains('Warnings'));
      expect(text, contains('minOuterSection'));
    });

    test('says none for the toe kick when off the floor', () {
      expect(
        builder.build(planFor(const Inputs(onFloor: false))),
        contains('Toe kick: none'),
      );
    });

    test('says none for trim and gaps by default', () {
      final text = builder.build(planFor());
      expect(text, contains('Trim around window: none'));
      expect(text, contains('Gaps around window: none'));
    });

    test('lists trim and gaps when set', () {
      final text = builder.build(
        planFor(const Inputs(trimTop: 2, trimLeft: 1, gapBottom: 0.5)),
      );
      expect(
        text,
        contains('Trim around window: top 2", bottom 0", left 1", right 0"'),
      );
      expect(
        text,
        contains('Gaps around window: top 0", bottom 1/2", left 0", right 0"'),
      );
    });

    test('includes the estimated cost with the ZIP and date', () {
      final text = builder.build(planFor());
      expect(text, contains('Estimated cost (ZIP 33713, prices updated'));
      expect(text, contains("Lowe's estimate: \$"));
      expect(text, contains('Estimated subtotal: \$'));
      expect(text, contains('Estimated sales tax (7%): \$'));
      expect(text, contains('Estimated total: \$'));
      expect(text, contains(r'$69.85 ='));
    });

    test('never says a price is missing', () {
      expect(builder.build(planFor()), isNot(contains('price not found')));
      expect(
        builder.build(planFor(const Inputs(edgeStiffener: true))),
        isNot(contains('price not found')),
      );
    });

    test('lists the recommended tools', () {
      final text = builder.build(planFor());
      expect(text, contains('Recommended tools'));
      expect(text, contains('- Stud finder'));
      expect(text, contains('- Pocket hole jig (optional)'));
    });
  });
}
