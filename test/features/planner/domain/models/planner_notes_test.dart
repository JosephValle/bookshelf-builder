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

    test('no note contains an em dash', () {
      for (final s in [
        PlannerNotes.disclaimer,
        PlannerNotes.store,
        PlannerNotes.wall,
      ]) {
        expect(s.contains('—'), isFalse);
      }
    });
  });
}
