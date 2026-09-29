import 'package:bookshelf_builder/features/planner/domain/models/dimensions.dart';
import 'package:bookshelf_builder/features/planner/domain/models/inputs.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part.dart';
import 'package:bookshelf_builder/features/planner/domain/models/part_material.dart';
import 'package:bookshelf_builder/features/planner/domain/services/parts_builder.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/plan_helpers.dart';

void main() {
  Part named(List<Part> parts, String name) =>
      parts.firstWhere((p) => p.name == name);

  group('default parts', () {
    final parts = planFor().parts;

    test('panels have the documented lengths', () {
      expect(named(parts, 'Top panel').length, 76);
      expect(named(parts, 'Bottom panel').length, 76);
      expect(named(parts, 'Outer column panel').qty, 2);
      expect(named(parts, 'Outer column panel').length, closeTo(71.0625, 1e-9));
      expect(named(parts, 'Inner column panel').qty, 2);
      expect(named(parts, 'Head panel').length, 48);
      expect(named(parts, 'Sill panel').length, 48);
    });

    test('column shelves are 6 per column at the clear width', () {
      expect(named(parts, 'Left column shelf').qty, 6);
      expect(named(parts, 'Right column shelf').qty, 6);
      expect(named(parts, 'Left column shelf').length, closeTo(12.5625, 1e-9));
    });

    test('bar dividers use the documented lengths', () {
      expect(named(parts, 'Top bar divider').length, closeTo(12.5625, 1e-9));
      expect(named(parts, 'Bottom bar divider').length, closeTo(9.0625, 1e-9));
    });

    test('3/4 inch parts are as wide as the panel depth', () {
      final wide = parts
          .where((p) => p.material == PartMaterial.ply34)
          .where((p) => !PartsBuilder.isNarrowStrip(p.name));
      for (final p in wide) {
        expect(p.width, closeTo(11.03125, 1e-9));
      }
    });

    test('toe kick uses the toe kick width', () {
      final kick = named(parts, PartsBuilder.toeKickName);
      expect(kick.width, 3.5);
      expect(kick.length, 76);
    });

    test('four back panels in 1/4 inch plywood', () {
      final backs = parts.where((p) => p.material == PartMaterial.ply14);
      expect(backs.length, 4);
      expect(named(parts, 'Back panel, left column').length, 76);
      expect(named(parts, 'Back panel, left column').width, 14);
    });

    test('the top bar has a solid anchor cleat', () {
      final cleat = named(parts, PartsBuilder.topCleatName);
      expect(cleat.qty, 1);
      expect(cleat.length, 48);
      expect(cleat.width, 3.5);
      expect(cleat.material, PartMaterial.ply34);
    });

    test('wall French cleat covers a top and mid-height row per column', () {
      final cleat = named(parts, PartsBuilder.wallCleatName);
      expect(cleat.qty, 1);
      expect(cleat.length, 2 * (14 + 14));
      expect(cleat.width, 3.5);
      expect(cleat.material, PartMaterial.ply34);
      expect(PartsBuilder.isNarrowStrip(PartsBuilder.wallCleatName), isTrue);
    });

    test('the unit half of the French cleat matches the wall half', () {
      final wall = named(parts, PartsBuilder.wallCleatName);
      final unit = named(parts, PartsBuilder.unitCleatName);
      expect(unit.qty, wall.qty);
      expect(unit.length, wall.length);
      expect(unit.width, wall.width);
      expect(PartsBuilder.isNarrowStrip(PartsBuilder.unitCleatName), isTrue);
    });

    test('no bottom cleat when resting on the floor', () {
      expect(parts.any((p) => p.name == PartsBuilder.bottomCleatName), isFalse);
    });

    test('no edge band and no column dividers by default', () {
      expect(parts.any((p) => p.material == PartMaterial.edgeBand), isFalse);
      expect(parts.any((p) => p.name.contains('column divider')), isFalse);
    });
  });

  group('variants', () {
    test('no toe kick when not on the floor', () {
      final parts = planFor(const Inputs(onFloor: false)).parts;
      expect(parts.any((p) => p.name == PartsBuilder.toeKickName), isFalse);
    });

    test('off the floor the bottom bar gets a cleat too', () {
      final parts = planFor(const Inputs(onFloor: false)).parts;
      expect(named(parts, PartsBuilder.bottomCleatName).width, 3.5);
    });

    test('a short bar gets a shorter cleat', () {
      final parts = planFor(const Inputs(top: 4.5)).parts;
      expect(
        named(parts, PartsBuilder.topCleatName).width,
        closeTo(4.5 - 1.4375, 1e-9),
      );
    });

    test('isNarrowStrip recognizes the ripped strips only', () {
      expect(PartsBuilder.isNarrowStrip(PartsBuilder.toeKickName), isTrue);
      expect(PartsBuilder.isNarrowStrip(PartsBuilder.topCleatName), isTrue);
      expect(PartsBuilder.isNarrowStrip(PartsBuilder.bottomCleatName), isTrue);
      expect(PartsBuilder.isNarrowStrip('Top panel'), isFalse);
    });

    test('edge band appears with the stiffener', () {
      final parts = planFor(const Inputs(edgeStiffener: true)).parts;
      expect(parts.last.material, PartMaterial.edgeBand);
    });

    test('tall bars add bar shelves', () {
      final parts = planFor(const Inputs(top: 20)).parts;
      expect(named(parts, 'Top bar shelf').qty, 2);
    });

    test('wide columns add column dividers per opening', () {
      final p = planFor(const Inputs(left: 40));
      expect(
        named(p.parts, 'Left column divider').qty,
        p.leftCol.dividers * (p.leftCol.shelves + 1),
      );
    });

    test('can be built directly', () {
      const i = Inputs();
      final plan = planFor(i);
      final parts = const PartsBuilder().build(
        inputs: i,
        dims: Dimensions.from(i),
        leftCol: plan.leftCol,
        rightCol: plan.rightCol,
        topBar: plan.topBar,
        bottomBar: plan.bottomBar,
      );
      expect(parts, plan.parts);
    });
  });
}
