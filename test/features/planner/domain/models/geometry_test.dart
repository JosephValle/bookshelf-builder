import 'package:bookshelf_builder/features/planner/domain/models/limits.dart';
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
}
