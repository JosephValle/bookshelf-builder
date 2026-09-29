import 'package:bookshelf_builder/features/planner/domain/services/piece_ids.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  final plan = planFor();
  final ids = PieceIds(plan);

  group('PieceIds', () {
    test('lists every id of a part', () {
      expect(ids.ids('Top panel'), ['A1']);
      expect(ids.ids('Bottom panel'), ['A2']);
      expect(ids.ids('Left column shelf').length, 6);
    });

    test('id picks one piece by index', () {
      expect(ids.id('Outer column panel', 0), ids.ids('Outer column panel')[0]);
      expect(ids.id('Outer column panel', 1), ids.ids('Outer column panel')[1]);
    });

    test('outer and inner column panels are different pieces', () {
      final all = {
        ...ids.ids('Outer column panel'),
        ...ids.ids('Inner column panel'),
      };
      expect(all.length, 4);
      expect(ids.label('Outer column panel'), ids.label('Inner column panel'));
    });

    test('an unknown part gives no ids and falls back to its name', () {
      expect(ids.ids('Nothing'), isEmpty);
      expect(ids.id('Nothing'), 'nothing');
      expect(ids.label('Nothing'), isEmpty);
    });

    test('an index past the end falls back to the name', () {
      expect(ids.id('Top panel', 5), 'top panel');
    });

    test('every id in the plan is unique', () {
      final all = [for (final p in plan.parts) ...p.ids];
      expect(all.toSet().length, all.length);
    });
  });
}
