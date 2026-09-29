import 'package:bookshelf_builder/features/planner/domain/services/bar_planner.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const planner = BarPlanner();

  group('plan', () {
    test('default top bar', () {
      final b = planner.plan(windowW: 48, barH: 14, kick: 0, span: 24);
      expect(b.dividers, 1);
      expect(b.dividerLength, closeTo(12.5625, 1e-9));
      expect(b.bayW, closeTo(23.640625, 1e-9));
      expect(b.tiers, 1);
    });

    test('default bottom bar subtracts the toe kick', () {
      final b = planner.plan(windowW: 48, barH: 14, kick: 3.5, span: 30);
      expect(b.dividers, 1);
      expect(b.dividerLength, closeTo(9.0625, 1e-9));
      expect(b.tiers, 1);
    });

    test('a tall bar gets two tiers', () {
      final b = planner.plan(windowW: 48, barH: 20, kick: 0, span: 24);
      expect(b.clearH, closeTo(18.5625, 1e-9));
      expect(b.tiers, 2);
    });

    test('tier threshold is two minimum bays plus a shelf', () {
      final at = planner.plan(windowW: 48, barH: 17.15625, kick: 0, span: 24);
      expect(at.clearH, closeTo(15.71875, 1e-9));
      expect(at.tiers, 2);
      final below = planner.plan(windowW: 48, barH: 17, kick: 0, span: 24);
      expect(below.tiers, 1);
    });

    test('a wider window adds dividers', () {
      final b = planner.plan(windowW: 60, barH: 14, kick: 0, span: 24);
      expect(b.dividers, 2);
    });
  });
}
