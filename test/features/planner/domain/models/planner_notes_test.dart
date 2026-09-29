import 'package:bookshelf_builder/features/planner/domain/models/planner_notes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlannerNotes', () {
    test('disclaimer says the limits are rules of thumb', () {
      expect(PlannerNotes.disclaimer, contains('rules of thumb'));
    });

    test('store note mentions per cut pricing', () {
      expect(PlannerNotes.store, contains('per cut'));
    });

    test('wall note mentions a French cleat and studs', () {
      expect(PlannerNotes.wall, contains('French cleat'));
      expect(PlannerNotes.wall, contains('studs'));
      expect(PlannerNotes.wall, contains('anchor cleat'));
    });

    test('the concrete wall note has no studs and names the fasteners', () {
      expect(PlannerNotes.wallConcrete, contains('French cleat'));
      expect(PlannerNotes.wallConcrete, contains('concrete screws'));
      expect(PlannerNotes.wallConcrete, contains('hammer drill'));
      expect(PlannerNotes.wallConcrete, contains('anchor cleat'));
      expect(PlannerNotes.wallConcrete, contains('mortar'));
      expect(PlannerNotes.wallConcrete, isNot(contains('studs')));
    });

    test('wallFor picks the note for the wall type', () {
      expect(PlannerNotes.wallFor(concrete: false), PlannerNotes.wall);
      expect(PlannerNotes.wallFor(concrete: true), PlannerNotes.wallConcrete);
    });

    test('no note contains an em dash', () {
      for (final s in [
        PlannerNotes.disclaimer,
        PlannerNotes.store,
        PlannerNotes.wall,
        PlannerNotes.wallConcrete,
      ]) {
        expect(s.contains('—'), isFalse);
      }
    });
  });
}
