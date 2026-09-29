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
      expect(text, contains('1 x Top panel'));
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
  });
}
